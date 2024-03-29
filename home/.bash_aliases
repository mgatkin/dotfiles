#!/bin/bash
alias aa='. $HOME/.bash_aliases'
alias ack='ack --color'
alias c='clear'
alias cless='less -r'
alias cls='rst; clear; rp'
alias cmore='less -r'
alias du0='du --max-depth=0'
alias du1='du --max-depth=1'
alias e='export PS1="\n### tty running eclipse ### (type rp to remove this message)\n\n\u@\h:\w\$ "; /usr/local/eclipse/eclipse &'
alias ea='vi $HOME/.bash_aliases'
alias eclipse='/usr/local/eclipse/eclipse'
alias hs='homeshick'
alias l='ls -laF'
alias ll='ls -laF --color=always | less -R'
#Remove make alias; adding -j8 at top level breaks build; need to investigate
#alias make='colormake -j8'
alias me='who | grep `whoami`'
alias more='less'
alias path='env | grep PATH'
alias rp='export PS1="\u@\h:\w\$ "'
alias rvm='runabout_test.sh'
alias rst='echo -e "\033[8;60;120t"'
alias schroot='schroot -p'
alias trim='cut -b-$(tput cols)'

#grep aliases
alias cgrep='find -name "*.c" -or -name "*.cc" -or -name "*.cpp" | xargs grep'
alias hgrep='find -name "*.h" -or -name "*.hpp" -or \( -not -name "*.*" -and -not -type d \) | xargs grep'
alias jgrep='find -name "*.java" | xargs grep'
alias phpgrep='find -name "*.php" | xargs grep'
alias plgrep='find -name "*.pl" | xargs grep'
alias pygrep='find -name "*.py" | xargs grep'
alias rbgrep='find -name "*.rb" -or -name "*.rhtml" -or -name "*.rjs" -or -name "*.rxml" | xargs grep'
