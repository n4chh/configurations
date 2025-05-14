function settarget() {
  echo "$1" > /Users/nachh/.local/target.txt
  if [[ `pwd` =~ .*"/$1" ]]; then 
    echo "$(pwd)" > /Users/nachh/.local/targetdir.txt
  else
    echo '' > /Users/nachh/.local/targetdir.txt
  fi
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
  export TARGETDIR="$(cat /Users/nachh/.local/targetdir.txt)"
}

function cdtarget() {
  export TARGETDIR="$(cat /Users/nachh/.local/targetdir.txt)"
  if [[ -d $TARGETDIR ]];then
    cd $TARGETDIR
  else
    echo >&2 '\033[31;1mERROR\033[0m: El objetivo no tiene un directorio válido' 
  fi
}

function setws() {
  if [ -d "$1" ]; then
    
    export WS="$(pwd)/$1";
  else
    export WS="$(pwd)"
  fi
  echo "$WS" >  /Users/nachh/.local/workspace.txt
}
function clearws() {
  echo "" > /Users/nachh/.local/workspace.txt
  export WS=""
}

function cdws() {
  export WS=$(cat /Users/nachh/.local/workspace.txt)
  if ! [ -d $WS ]; then 
    echo "\033[31;1mERROR\033[0m: No hay ningun espacio de trabajo"
  else
    cd $WS
  fi
}

function mktarget() {
  mkdir -p $1/{nmap,content,exploits,Imgs}
}

function setdn() {
  echo "$1" > /Users/nachh/.local/dn.txt
  export TARGET="$(cat /Users/nachh/.local/dn.txt)"
}

function cleardn() {
  echo "$1" > /Users/nachh/.local/dn.txt
  export TARGET="$(cat /Users/nachh/.local/dn.txt)"
}

function cleartarget() {
  echo "" > /Users/nachh/.local/target.txt
  echo "" > /Users/nachh/.local/targetdir.txt
  export TARGETDIR="$(cat /Users/nachh/.local/targetdir.txt)"
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
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

function litend() {
  local address="$1"
  local little_endian=""
  address=${address#0x}
  local num_bytes=$(( ${#address} / 2 ))

  for (( pos = num_bytes - 1; pos >= 0; pos-- )); do
    local byte="${address:$pos*2:2}"
    little_endian+="\\\\x$byte"
  done

  echo "${little_endian}"
}


function rot13() {
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

function getports() {
  export PORTS=$(cat allports_tcp | grep Ports | tail -n 1  | awk '{for (i=4; i < NF -4; i++) printf $i}' | sed 's/\/\/\//\n/g' | tr -s ':,' '/' | cut -d '/' -f 2 | xargs | tr -s ' ' ',')
  echo "Sourced ports: $PORTS"
}

