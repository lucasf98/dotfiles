# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export PATH=~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH
export LS_COLORS='no=00:fi=00:di=36:ln=01;34:pi=40;33:so=35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=32:*.cmd=32:*.exe=32:*.com=32:*.btm=32:*.bat=32:*.sh=32:*.csh=32:*.tar=31:*.tgz=01;31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.bz2=31:*.bz=31:*.tz=31:*.rpm=31:*.cpio=31:*.jpg=35:*.gif=35:*.bmp=35:*.xbm=35:*.xpm=35:*.png=35:*.tif=35:'
export VISUAL=/usr/bin/vim
[[ -z $DISPLAY ]] || [[ "$DISPLAY" == "localhost" ]] && export DISPLAY=":0.0"
export PS1='\[\033[32m\]\u@\h \[\033[36m\]\W \$ \[\033[00m\]'

shopt -s nocaseglob
shopt -s histappend
shopt -s cdspell

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

function word()
{
	grep $* /usr/share/dict/web2 
}

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
/bin/ls --color=auto &> /dev/null && alias ls="ls --color=auto"
alias l="ls -al"
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

if [ "$(uname)" == "Darwin" ]; then
    # macOS specific config
    echo Welcome to macOS!
    alias ls="ls -G"
    alias qtfull="osascript -e 'tell application \"Quicktime Player\" to present movie 1'"
    alias sc="ssh -L 4200:localhost:4243 luke@chewbacca"
    alias sr2d2="ssh root:openelec@192.168.1.129"
    alias sp="ssh root@iphone"
    alias ss="( ssh mythtv@chewbacca esd -nobeeps -tcp -public -terminate -r 44100 ) & sleep 4 ; esdrec -r 44100 | esdcat -r 44100 -s chewbacca"
    alias cdr2iso="hdiutil makehybrid -iso -joliet -o"
elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
    # Cygwin specific config
    echo Welcome to Cygwin!
    alias open="cygstart"
fi

# Python Configuration
export PYTHONSTARTUP=$HOME/.pythonrc

# Source Git Completion
if [ -f $HOME/git-completion.sh ]; then
    . $HOME/git-completion.bash
fi

# Source local definitions
if [ -f $HOME/.bashrc.local ]; then
	. $HOME/.bashrc.local
fi
