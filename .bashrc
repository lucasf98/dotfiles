# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
[[ -f /etc/bashrc ]] && source /etc/bashrc

shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

set -o ignoreeof

# User specific aliases and functions
export PATH=~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export LS_COLORS='no=00:fi=00:di=36:ln=01;34:pi=40;33:so=35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=32:*.cmd=32:*.exe=32:*.com=32:*.btm=32:*.bat=32:*.sh=32:*.csh=32:*.tar=31:*.tgz=01;31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.bz2=31:*.bz=31:*.tz=31:*.rpm=31:*.cpio=31:*.jpg=35:*.gif=35:*.bmp=35:*.xbm=35:*.xpm=35:*.png=35:*.tif=35:'
export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
[[ -z $DISPLAY || "$DISPLAY" == "localhost" ]] && export DISPLAY=":0.0"
export PS1='\[\033[32m\]\u@\h \[\033[36m\]\W \$ \[\033[00m\]'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

case $TERM in
	xterm*|dtterm|Eterm|eterm)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

function word() {
    grep $* /usr/share/dict/web2
}

# Set the title of a Terminal window
function settitle() {
    if [ -n "$STY" ] ; then         # We are in a screen session
        echo "Setting screen titles to $@"
        printf "\033k%s\033\\" "$@"
        screen -X eval "at \\# title $@" "shelltitle $@"
    fi
    printf "\033]2;%s\a" "$@"
}

function adbv() {
  TEMPFILE=$(mktemp)
  adb pull "$1" "$TEMPFILE"
  vim "$TEMPFILE"
  adb push "$TEMPFILE" "$1"
}

function rg() {
    grep -rin "$@" .
}

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
/bin/ls --color=auto &> /dev/null && alias ls="ls --color=auto"
alias l="ls -alh"
alias ..="cd .."
alias ...="cd ../../"
alias psh="pushd"
alias pop="popd"
alias rd="rmdir"
alias md="mkdir"
alias less="less -r"
alias more="less"
alias m="more"
alias h="history"
alias l.="ls -d .*"
alias vi="vim"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias g='git'

if [[ "$(uname)" == "Linux" ]]; then
    # linux specific config
    echo -n "Welcome to Linux! "
    alias open="xdg-open"
    alias copy="xsel -ib"
elif [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific config
    echo -n "Welcome to macOS! "
    alias ls="ls -G"
    alias qtfull="osascript -e 'tell application \"Quicktime Player\" to present movie 1'"
    alias sc="ssh -L 4200:localhost:4243 luke@chewbacca"
    alias sr2d2="ssh root:openelec@192.168.1.129"
    alias sp="ssh root@iphone"
    alias ss="( ssh mythtv@chewbacca esd -nobeeps -tcp -public -terminate -r 44100 ) & sleep 4 ; esdrec -r 44100 | esdcat -r 44100 -s chewbacca"
    alias cdr2iso="hdiutil makehybrid -iso -joliet -o"
    alias copy='pbcopy'
    alias matlab='/Applications/MATLAB_R2017b.app/bin/matlab -nodesktop -nosplash'
    alias meld='open /Applications/Xcode.app/Contents/Applications/FileMerge.app/'
elif [[ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]]; then
    # Cygwin specific config
    echo -n "Welcome to Cygwin! "
    alias open="cygstart"
    alias copy="putclip"
    alias bfg='java -jar c://cygwin64//home//lmfranka//bin//bfg.jar'
    export BROWSER='/usr/bin/cygstart %s'
    export TERM=cygwin
fi

# Python Configuration
export PYTHONSTARTUP=${HOME}/.pythonrc

missing_features=( )

# Source Git Completion
if [[ -f ~/.git-completion.bash ]]; then
  source ~/.git-completion.bash
  __git_complete g __git_main
  __git_complete config __git_main
else
  missing_features+=( "-git-completion" )
  # Installation instructions:
  #  1. Download https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
  #  2. Save as ${HOME}/.git-completion.bash
fi

if [[ -f $HOME/.bash-git-prompt/gitprompt.sh ]]; then
  GIT_PROMPT_ONLY_IN_REPO=1
  source "$HOME/.bash-git-prompt/gitprompt.sh"
else
  missing_features+=( "-gitprompt" )

  # Git Bash Prompt
  function git_prompt {
      ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      mod=$(git status --porcelain 2> /dev/null)
      echo " (${ref#refs/heads/}${mod:+*})"
  }

  # Installation instructions:
  #   cd ~ && git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

  # basic Git prompt
  export PS1='\[\033[32m\]\u@\h \[\033[36m\]\W\[\033[35m\]$(git_prompt)\[\033[36m\] \$ \[\033[00m\]'
fi

if [[ -f /usr/share/autojump/autojump.bash ]]; then
  source /usr/share/autojump/autojump.bash
elif [[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]]; then
  source /Users/frankart/.autojump/etc/profile.d/autojump.sh
else
  missing_features+=( "-autojump" )
  # Installation instructions:
  #  https://github.com/wting/autojump
fi

echo "${missing_features[@]}"

# Source local definitions
[[ -f "${HOME}/.bashrc.local" ]] && source "${HOME}/.bashrc.local"

