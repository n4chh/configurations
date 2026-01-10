
function log() {
    case "$1" in
    0 | SUCCESS)
        shift
        echo "[$(tput setaf 2)+$(tput sgr0)] $@"
        ;;
    1 | INFO)
        shift
        echo "[$(tput setaf 4)*$(tput sgr0)] $@"
        ;;
    2 | WARNING)
        shift
        echo "[$(tput setaf 3)!$(tput sgr0)] $@"
        ;;
    3 | ERROR)
        shift
        echo "[$(tput setaf 1 bold)X$(tput sgr0)] $@"
        ;;
    4 | QUESTION)
        shift
        echo "[$(tput setaf 5 bold)?$(tput sgr0)] $@"
        ;;
    *)
        echo "$@"
        ;;
    esac

}

function mkptdir ()
{
	local folder=$1
	local MAIN_FILES=(
		"burp/"
		"misc/"
		"data/"
		"notes.md"
		)
	local file=""
	mkdir $folder
	cd $folder

	for ((i = 0; i <= ${#MAIN_FILES[@]}; i++)); do
		file="${MAIN_FILES[$i]}"
		if [[ $file == "" ]]; then
			continue
		elif [[ ${file[-1]} == "/" ]]; then
			mkdir "$file"
		else
			touch "$file"
		fi
	done

}

function spinner() {
	local message="$@"
	local frames=(
		"󰪞 "
		"󰪟 "
		"󰪠 "
		"󰪡 "
		"󰪢 "
		"󰪣 "
		"󰪤 "
		"󰪥 "
		)
	tput civis
	while : ;do 
		for (( i=0; i < ${#frames[@]}; i++)); do
			sleep 0.1
			echo -ne "\r\e[34m${frames[$i]}\e[0m$message"
		done
	done
	tput cnorm
}

function upgrade_shell() {
	# -----------------------------------------------------
	# Node Version Manager
	# -----------------------------------------------------

	[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
	[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
	eval "$(isengardcli shell-profile)"
}


function select_tmux_session() {
	local sessions=($@)
	sessions="$(echo "$sessions" | awk -F: '{print $1 " " $0}')"
	local preview_cmd="export session={};\
echo \"\e[1mNAME:\e[0m \$(echo \$session | cut -d ' ' -f1)\";\
echo \"\e[1mWINDOWS:\e[0m \$(echo \$session | cut -d ' ' -f3)\";\
echo \"\e[1mCREATION DATE:\e[0m \$(echo \$session | awk '{print \$6, \$7, \$8, \$9, \$10}' | tr -d \))\";\
echo \"\e[1mATTACHED:\e[0m \$(if grep -q attached <<< \$session ; then echo -e '\e[32;1mYes\e[0m'; else echo No; fi)\"\
"
	fzf  --with-nth 1 --preview "$preview_cmd" <<< "$sessions" | cut -d ' ' -f 1
}

function select_ssh_host(){
	local hosts=($(awk '!seen[$1]++ && $1 ~ "'"$(whoami)"'" {print $1}' ~/.ssh/known_hosts))
	local alias=($(grep -E -B 1 "${(j:|:)hosts}" ~/.ssh/config | awk '$0 !~ "'"${(j:|:)hosts}"'" {print $2}' ))
	local host=$(fzf --preview "echo '\e[1mALIAS:\e[0m\t\t{}' | tr -d \"\'\"; echo \"\e[1mHOSTNAME:\e[0m\t\$(ssh -GT {} | awk '\$1 == \"hostname\" {print \$2}')\"" <<< ${(F)alias})
	log INFO "Checking for TMUX session on remote hosts."
	# local sessions=($(ssh $host -Tt 'source ~/.zshrc; tmux ls'))
	# local session=$(select_tmux_session "$sessions")

	ssh $host
	# exec ssh $host -t "source ~/.zshrc; tmux attach -t '$session'"
}

# HTTP Proxy
function set_http_proxy() {
  if [ -e $HOME/.proxyrc ]; then
    . $HOME/.proxyrc
  fi
  HOST=localhost
  PORT=${1:-8080}
  if [ -z $http_proxy ]; then
    echo "No proxy config, environment found, connection attempt failed."
    echo "Let's setup a config or update your password."
    echo "Using ${HOST}:${PORT}"
    http_proxy="http://${HOST}:${PORT}/"
    https_proxy="http://${HOST}:${PORT}/"
    echo "export http_proxy=$http_proxy" > $HOME/.proxyrc
    echo "export HTTP_PROXY=$http_proxy" >> $HOME/.proxyrc
    echo "export https_proxy=$https_proxy" >> $HOME/.proxyrc
    echo "export HTTPS_PROXY=$https_proxy" >> $HOME/.proxyrc
    echo "export AWS_CA_BUNDLE=/Users/igortego/Desktop/Burp/Certs/burp.pem" >> $HOME/.proxyrc
    . $HOME/.proxyrc
  fi
}

function kill_http_proxy() {
  rm $HOME/.proxyrc
  unset_http_proxy
}

function unset_http_proxy() {
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset AWS_CA_BUNDLE
}
