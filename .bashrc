# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# format shell prompt
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h [\@]: \[\e[0;93m\]\w\[\e[0m\]\n\$ '
#export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[0;34m\]\w\[\e[0m\]\n\$ '

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

# Append to the file, instead of having each session overwrite the entire file when it closes
# (a useless feature when hopping across multiple sessions)
shopt -s histappend
export HISTFILESIZE=3000000
export HISTSIZE=3000000

# Ignore/consolidate duplicate commands, and ignore commands starting with a space
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T '

# Save and reload history after each command. By default history is flushed out upon session
# close, which won't happen if we crash.
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export EDITOR="emacs"

go() {
    # dhullihe: rev-parse only returns 'true' when you're, well, in the repo. But if are not, then it will just print
    # to stderr and not return 'false'. But the return codes implicitly tell you want you need to know, so just look
    # at that.
    git rev-parse --is-inside-work-tree > /dev/null 2>&1

    if [ $? -eq 0 ]; then
       cd `git rev-parse --show-toplevel`
        # Save the location for later cases where we aren't in the repo. This means we can always cd back to
        # the root of the last repo we go'd to
        export GIT_ROOT=`git rev-parse --show-toplevel`
    elif [ -z "$GIT_ROOT" ]; then
        echo "\$GIT_ROOT not set. Where do I go my dude?"
    else
        cd "$GIT_ROOT"
    fi
}

# dhullihe: Stuff for getting up the ssh agent
# Need to explicitly pull in the latest cert given we may have regenerated it off-host and copied it over
# Especially needed for maintaining credentials for the git repo
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    ssh-add rasp_pi;
}