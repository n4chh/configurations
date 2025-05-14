set termguicolors
function settarget() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function cleartarget() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function setws() {
  if [ -d "$1" ]; then
    export WS="$1";
  else
    export WS="$(pwd)"
  fi
  echo "$WS" >  /Users/nachh/.local/workspace.txt
}

function clearws(){
  echo "" >  /Users/nachh/.local/workspace.txt
}

function cdws() {
  export WS=$(cat /Users/nachh/.local/workspace.txt)
  if [ -z $WS ]; then 
    echo "ERROR: No hay ningun espacio de trabajo"
  else
    cd $WS
  fi
}

function hex-encode() {
  echo "$@" | xxd -p
}

function hex-decode() {
  echo "$@" | xxd -p -r
}
function showcolors() {
  for i in {0..255}; do 
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done

}
function rot13() {
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

function mkws() {
  mkdir -p $1/{nmap,content,exploits,Imgs}
}

export TARGET="$(cat /Users/nachh/.local/target.txt)"
export WS="$(cat /users/nachh/.local/workspace.txt)"
#
# INCLUSION BINARIOS
#
# PYTHON TO PYTHON3
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
# JOHN tools
export PATH="/opt/homebrew/Cellar/john-jumbo/1.9.0_1/share/john:$PATH"
# OPENSSL PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# ERROR PATH DOCKER 
export PATH="$PATH:/usr/local/bin"
# HOMEBREW
eval "$(/opt/homebrew/bin/brew shellenv)"
# Ruby Version Manager
export PATH="$HOME/.rvm/bin:$PATH"
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# FINDUTILS
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
#VMWARE OVF TOOLS
export PATH="$PATH:/Applications/VMware OVF Tool"
#PIPx Binarios
export PATH="$PATH:$HOME/.local/bin"
#Binarios Arch64
export PATH="$PATH:/usr/local/opt/brew/bin"
# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#
#-------/ CUSTOM ALIASES /-------
#
alias bashcolors='for ((i=0; i<256; i++)); do printf "\e[48;5;%dm\e[38;5;15m%3d\e[0m " "$i" "$i"; if (( (i+1) % 16 == 0 )); then echo; fi; done'
alias ls='ls -G'
alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -laF --group-dirs=first'
alias l='lsd -F --group-dirs=first'




function putFG(){
  foreground=$1
  f_seq="\[\033[38;5;${foreground}m\]"
  echo -n "${f_seq}"
}
function putBG(){
  background=$1
  b_seq="\[\033[38;5;${background}m\]"
  echo -n "${b_seq}"
}

italic="\[\033[3m\]"
bold="\[\033[1m\]"
R="\[\033[0m\]"
function parse_git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    local status=$(git status --porcelain)
    local untracked=$(git ls-files --others --exclude-standard)
    local changed=$(git diff --name-only)
    local untracked_count=$(echo -n "$untracked" | wc -l | tr -d ' ')
    local changed_count=$(echo -n "$changed" | wc -l | tr -d ' ')
    local branch_info=""
        
    if [ -n "$status" ] || [ -n "$untracked" ]; then
      # Branch has uncommitted changes or untracked files
      branch_info+="$(putFG 221)$branch"  # Display branch name in red with asterisk
      if [ "$untracked_count" -gt 0 ]; then
        branch_info+=" $(putFG 39)?$untracked_count"  # Display untracked count with asterisk character
      fi
    else
      # Branch has no uncommitted changes or untracked files
      branch_info+="$(putFG 28)$branch"  # Display branch name in green
    fi
    if [ "$changed_count" -gt 0 ]; then
      branch_info+=" $(putFG 178)"$'\u2699'"$changed_count"  # Display changed count with gear character
    fi
    echo -n "$branch_info$R"
  fi
}




# Line character
L='─'
# Right Delimitor
RD=']'
# Left Delimitor
LD='['
# Right Parentesis Delimitor
RPD=')'
# Left Parentesis Delimitor
LPD='('
# Other Right Delimitor
OLD='┨'
# Other Left Delimitor 
ORD='┠'
promptFG=9


function workspace()
{
  local WSIC=$1
  local WSinfo=""
  if [ -d "$WS" ]; then
    WSinfo+="$(putFG $WSIC)$(echo -n $WS | awk -F'/' '{print $NF}')"
  fi
  echo -n "$WSinfo"
}

function stripColors(){
  local str=""
  str="$(echo -n "$1" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  echo -n "$str"
}

function user() {
  local UP="$L$LD"
  local usernamecolor=255 
  if [ "$USER" == "root" ]; then
    usernamecolor=1
    UP+=$bold
  fi
  UP+="$(putFG $usernamecolor)$USER$R"
  if [ -d "$WS" ]; then
    local wscolor=39
    UP+="$bold@$R$(workspace $wscolor)"
  fi
  UP+="$(putFG $promptFG)$RD"
  echo -n "$UP"
}

function prompt() {
  local status=$?
  if [ "$USER" != "root" ]; then
    iconFG=27
    iconFG=11
    icon=$' '
    icon=$'󰫻'
  else
    # promptFG=8
    iconFG=1
    icon=$' '
    icon=$'󰫻'
  fi
  #Github Prompt
  local GS="$(git branch 2>/dev/null)"
  local GP=""
  local GP_l=""
  if [ -n "$GS" ]; then
    #Github Icon
    GI=""
    INFO=$(parse_git_branch)
    #Untracked files
    # Github Color
    GC=77
    GP="$LPD$(putFG 27)$GI$(putFG $promptFG)$RPD$OLD${INFO}$(putFG $promptFG)$ORD"
    GP_l="$(echo -n $GP | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  fi
  # User Prompt
  local UP="$(putFG $promptFG)|$(putFG $iconFG)$icon$R$(putFG $promptFG)|"
  local UP_l="$(echo -n $UP | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  # Line 1
  local L1="$(putFG $promptFG)"$'\u250C'"$L"

  # Workspace Icon
  local WSicon=""
  local WSIC=46
  # Workspace Prompt
  local WP=""
  export WS="$(cat /users/nachh/.local/workspace.txt)"
  if [ -d "$WS" ]; then
    # Workspace Prompt
    WP="$L$LD$(putFG $WSIC)${WSicon} $(putFG 7)$(workspace)$(putFG $promptFG)$RD"
  fi
  WP="$(user)"
  local WP_l="$(echo -n "$WP" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"

  # Directory propmt
  local DIR=""
  if [ -n "$WS" ] && [ -n "$(echo -n $PWD | grep $WS)" ]; then
    DIR=$(echo -n $PWD | sed -E "s#$WS##")
  elif [ -n "$(echo -n $PWD | grep "$HOME")" ]; then
    DIR=$(echo -n $PWD | sed -E "s#$HOME#󰀶#")
  else
    DIR=$PWD
  fi
  local DC=7
  local DP="$L$LD$(putFG $DC)$DIR$R$(putFG $promptFG)$RD"
  local DP_l="$(echo -n "$DP" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  
  local cols=$(tput cols)
  local chars=$(( cols - ${#DP_l} - ${#UP_l} - ${#GP_l} - ${#WP_l}))
  local line=""
  for ((i = 2; i < chars; i++)); do
    line+=$L
  done
  local ECFG=""
  local EP=""
  if [ $status -eq 0 ]; then
    # Error Color
    ECFG=11
    # Error Prompt
    EP=""
    # PS1="$L1$line$UP\n"$'\u2514\u2500'" $R"
  else
    # Error Color
    ECFG=196
    # Error Prompt
    EP="($(putFG $ECFG)$bold[x]$R $status$(putFG $promptFG))"
    # PS1="$L1$line$UP\n"$'\u2514\u2500'"❨$(putFG 1)󰃤$R $status $(putFG $promptFG)❩$(putFG 1)$R "
  fi
  # Input Char
  local IC=""
  if [ "$USER" != "root" ]; then
    IC="$(putFG $ECFG)$bold\$$R"
  else
    IC="$(putFG $ECFG)$bold#$R"
  fi
  # Line Union
  local LU=$'\u2514\u2500'
  # Prompt String 1
  PS1="$L1$WP$DP$GP$line$UP\n$LU$EP$IC"
}

PROMPT_COMMAND=prompt
