echo "Loading TH3COD3 settings..."

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ -z "$NO_TMUX" ]; then
  if [[ -n $VSCODE_WORKSPACE ]]; then
    exec tmux new-session -As $VSCODE_WORKSPACE
  fi
  exec tmux new-session -A -s main
fi

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# Git branch bash completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash

  # Add git completion to aliases
  __git_complete g __git_main
  __git_complete gco _git_checkout
  __git_complete gcob _git_checkout
  __git_complete gc _git_commit
  __git_complete gca _git_commit
  __git_complete gm _git_merge
  __git_complete gp _git_pull
  __git_complete gP _git_push
  __git_complete gcp _git_cherry_pick
  __git_complete gs _git_status
  __git_complete grb _git_rebase
  __git_complete grbi _git_rebase
  __git_complete gr _git_reset
  __git_complete grh _git_reset
  __git_complete grs _git_reset
  __git_complete gb _git_branch
fi

function git_branch_name() {
    echo $(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
}

export PS1='\n\[\e[1;37m\]|-- \[\e[1;32m\]\u\[\e[0;39m\]@\[\e[1;36m\]\h\[\e[0;39m\]:\[\e[1;33m\]\w\[\e[0;39m\]\[\e[1;35m\] $(git_branch_name)\[\e[0;39m\] \[\e[1;37m\]--|\[\e[0;39m\]\n$ '

export XDG_CONFIG_HOME="$HOME/.config"

export TH3COD3_SETTINGS_LOADED=1
