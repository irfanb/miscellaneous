# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

    XTERM_TITLE='bum'

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    XTERM_TITLE='xterm\[\033]0;\W@\u@\H\007\]'
    ;;
screen)
    XTERM_TITLE='screen\[\033]0;\W@\u@\H\007\]'
    ;;
*)
    ;;
esac

PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
export PATH=/opt/android-sdk-linux_x86/tools:$PATH
export IFS=$'\t\n'
export FIGNORE=svn

