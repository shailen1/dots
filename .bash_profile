#!/bin/bash

# define all functions in  this file

function px { ps -aux | grep "$1" | grep -v "grep" ; }

fr() { cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n $1; }
gip() { curl -D - http://freegeoip.net/xml/$1; }
mcd() { mkdir -p "$1" && cd "$1"; }


function spy () {
    lsof -i -P +c 0 +M | grep -i "$1" 
}

sssh (){ ssh -t "$1" 'tmux attach || tmux new'; }

function mn ()
{
        man $1 | col -b | grep -i --color=auto $2 | less
    }

function wi() {
    if [ "${1}" ]; then dig +short "${1}".wp.dg.cx TXT; fi
}

function tre() {

    SEDMAGIC='s;[^/]*/;|____;g;s;____|; |;g'

    if [ "$#" -gt 0 ] ; then
       dirlist="$@"
    else
       dirlist="."
    fi

    for x in $dirlist; do
         find "$x" -print | sed -e "$SEDMAGIC"
    done
}

function fe() {
     if [ "$#" -gt 1 ] ; then
         gfind . -name "*.erl" "$1" -type f | grep -v "git" | grep -v ".log" | xargs grep -i  --color=auto "$2"
     else     
         gfind . -name "*.erl" -type f | grep -v "git" | grep -v ".log" | xargs grep -i  --color=auto "$1"
     fi
}

function t() {
     if [ "$#" -gt 1 ] ; then
         find "$1" -type f -name "$2"
     else	     
         find . -type f -name "$1"
     fi
}


function g() {
     find . -type f | xargs grep -in  --color=auto "$1";
}

function srvd(){
    python -m SimpleHTTPServer  1024 $1 & 2>&1
}

function authme() {
  ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' \
    < ~/.ssh/id_dsa.pub
}

function parse_git_branch () {
  if git rev-parse --git-dir >/dev/null 2>&1
  then
          gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
          return 0
  fi
  echo -e $gitver
}

function branch_color () {

        if git rev-parse --git-dir >/dev/null 2>&1
        then
                color=""
                if git diff --quiet 2>/dev/null >&2 
                then
                        color="${c_green}"
                else
                        #color="\xE2\x98\xA0${c_red}"
                        color="${c_yellow}"
                fi
        else
                return 0
        fi
        echo -ne $color
}
function k()
{
  if [ "$TERM" = "linux" ]
then
        #we're on the system console or maybe telnetting in
        export PS1="\[\e[32;1m\]\u@\H > \[\e[0m\]"
else
        #we're not on the console, assume an xterm
        export PS1="\[\e]2;\u@\H \w\a\e[32;1m\]>\[\e[0m\] " 
fi
}
IBlack="\[\033[0;37m\]" ;      # Black
Color_Off="\[\033[m\]" ;

#export PS1=$IBlack'[\T on \d]'$ColorOff' (\u) [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] on \H\n@ ${c_green}${c_blue}\w${c_sgr0}:\n=> \[\e]2;$(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g") \w\a\e[32;1m\]\[\e[0m\] '
export PS1=$IBlack'[\T]'$ColorOff' (\u) [\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] on \H\n@ ${c_green}\]${c_blue}\w${c_sgr0}:\n=> \[\e]2; \w\a\e[32;1m\]\[\e[0m\] '



