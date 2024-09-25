echo "Loading TH3COD3 settings..."

if [[ -z BASH_PROFILE_LOADED ]]; then
    echo "Loading ~/.bashrc"
    export BASH_PROFILE_LOADED=1
    . ~/.bashrc
fi

# Git branch bash completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash

    # Add git completion to aliases
    __git_complete g __git_main
    __git_complete gco _git_checkout
    __git_complete gcob _git_checkout
    __git_complete gm _git_merge
    __git_complete gp _git_pull
    __git_complete gP _git_push
fi

function git_branch_name() {
    echo $(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
}

export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(git_branch_name)\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n$ '

export XDG_CONFIG_HOME="$HOME/.config"

if [[ -z TH3COD3_SETTINGS_LOADED ]]; then
    echo "TH3COD3 settings was already loaded."
    return;
fi

export TH3COD3_SETTINGS_LOADED=1
