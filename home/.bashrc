# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# Comment out for now; having non-interactive aliases is useful
#case $- in
#    *i*) ;;
#      *) return;;
#esac

# Shell Options

# Don't wait for job termination notification
set -o notify

# For more bash history options, see http://unix.stackexchange.com/q/1288,
# http://stackoverflow.com/questions/103944
shopt -s histappend
export HISTCONTROL=ignoredups
export HISTIGNORE=" *"
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
#export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export FIGNORE=.svn

# Keep VT-100 line-drawing characters ("lqqqk") from showing up in PuTTY.
# http://stackoverflow.com/q/8483798/25507, http://superuser.com/q/278286/4160
export NCURSES_NO_UTF8_ACS=1

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Customize prompt.  Based on Debian's .bashrc.
#if [ $(uname) == 'Linux' ]; then
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
cygwin)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" -a -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias please='sudo !!'

alias vless=/usr/share/vim/vim[0-9]*/macros/less.sh
if [[ $(uname) == Darwin ]]; then
    alias gvim=mvim
fi

alias reset='reset; printf "\033[8;60;120t"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Windows, Cygwin, Embarcadero RAD Studio
if [[ $(uname) != Darwin && $(uname -o) == Cygwin ]]; then
    export cygPROGRAMFILES='/cygdrive/c/Program Files (x86)'
    alias cdapp='cd /cygdrive/c/trunk/app'
    alias cdcg='cd "$cygPROGRAMFILES/Embarcadero/Studio/17.0"'
    alias cdinc='cd "$cygPROGRAMFILES/Embarcadero/Studio/17.0/include"'
    alias cdsrc='cd "$cygPROGRAMFILES/Embarcadero/Studio/17.0/source"'

    alias gvim="HOME=$(cygpath \"$HOMEDRIVE$HOMEPATH\") cmd /c gvim"
fi

export EDITOR=vim
export SVN_EDITOR=vim
export PATH=$PATH:~/bin
export LUA_CPATH=";;/usr/local/lib/lua/5.1/?.so"
export GCC_COLORS=1
export LANG="en_US.UTF-8"

# ack is known as ack-grep on Debian / Ubuntu
if ! which ack >& /dev/null; then
    alias ack=ack-grep
fi

# make
# Disable for now, since g++ added its own color support.
#if which colormake >& /dev/null; then
#    alias make=colormake
#fi
# See http://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
alias dbgmake="\\make -f~/bin/Makefile.debug"

if [ -x /usr/local/eclipse/eclipse ]; then
    alias eclipse=/usr/local/eclipse/eclipse
fi

alias schroot='schroot -p'

# ack aliases
alias cgrep='ack --cc --cpp'
alias hgrep='ack --hh'
alias jgrep='ack --java'
alias plgrep='ack --perl'
alias pygrep='ack --python'
alias phpgrep='ack --php'
alias rbgrep='ack --ruby'

alias histgrep='history | grep'


# Ruby Gems
if [ -d $HOME/gems ]; then
    export GEM_HOME=$HOME/gems
    export GEM_PATH=$HOME/gems:/usr/lib/ruby/gems/1.8/
    export PATH=$HOME/gems/bin:$PATH
fi


# Python
export PYTHONSTARTUP=~/.pythonrc

# Manually managed virtualenv:
#alias pyenv='source ~/pyenv/bin/activate'

# Using pyenv:
if which pyenv >& /dev/null; then eval "$(pyenv init -)"; fi

#To activate *everything*:
#pyenv shell system 2.7.10 3.3.6 3.2.6 3.1.5 2.6.9 2.5.6 pypy-c-jit-latest

#To use Homebrew's directories rather than ~/.pyenv add to your profile:
#export PYENV_ROOT=/usr/local/var/pyenv


# Subversion
# From frankcortes/svn-stash:
alias svn-stash='python ~/.homesick/repos/svn-stash/svn-stash.py'
alias svn-icdiff='svn diff --diff-cmd=icdiff'

# Enable programmable completion.  May already be done in /etc/bash.bashrc.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if which brew >& /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi
. ~/bin/django_bash_completion

# On OS X, use GNU stuff instead of OS X stuff, courtesy of Homebrew.
if [ -d /usr/local/opt/findutils ]; then
    alias find=gfind
fi

# Based on http://mmb.pcb.ub.es/~carlesfe/unix/tricks.txt:
function lt() { ls -ltra "$@" | tail; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }

# From http://fredkschott.com/post/2014/02/git-log-is-so-2005/
# git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"

function lookuperror
{
    cpp -dM /usr/include/errno.h | grep -w "$@"
    perl -MPOSIX -e 'print strerror($ARGV[0])."\n";' $@
}

export DEBFULLNAME="Mark Atkin"

# Make unit tests that use Google Test include time taken by default.
export GTEST_PRINT_TIME=1

# Additional development stuff
if [ -f ~/trunk/app/scripts/dev.bashrc ]; then
    . ~/trunk/app/scripts/dev.bashrc
fi

ulimit -c unlimited

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Sample ssh-agent setup
if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi


# Homeshick configuration. See the Homeshick tutorial.
# Skip this if we're running in a git-less chroot.
if which git >& /dev/null; then
    source "$HOME/.homesick/repos/homeshick/homeshick.sh"
    source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
    if [[ $- == *i* ]]; then
        homeshick refresh
    fi
fi

# Optional machine-specific aliases
test -f ~/.bashrc.local && . ~/.bashrc.local

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=30;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
