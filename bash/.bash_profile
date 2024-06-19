. "$HOME/.bashrc"

# Git branch bash completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash

    # Add git completion to aliases
    __git_complete g __git_main
    __git_complete g-c _git_checkout
    __git_complete g-cb _git_checkout
    __git_complete g-m _git_merge
    __git_complete g-pl _git_pull
    __git_complete g-ps _git_push
fi

function git_branch_name() {
    echo $(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
}

export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\]$(git_branch_name)\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n$ '

export XDG_CONFIG_HOME="$HOME/.config"
