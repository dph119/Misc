# format shell prompt
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h [\@]: \[\e[0;93m\]\w\[\e[0m\]\n\$ '

# get rid of the stupid terminal freezing when you accidentally hit CTRL+S
stty -ixon 

# to make sure after each command the values of LINES and COLUMNS
# gets updated correctly. Otherwise a copy/paste may corrupt 
# everything you see
shopt -s checkwinsize 

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h='history'
alias ls="ls -h --color"
alias ll="ls -lh"
alias vi="vim"
alias la="ls -a"
alias g="grep"
alias l="less"

export HISTFILESIZE=3000
export HISTSIZE=3000
