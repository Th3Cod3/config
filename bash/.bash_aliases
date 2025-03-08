echo "Loading .bash_aliases"

alias shr='unset BASH_ALIASES_LOADED BASH_PROFILE_LOADED TH3COD3_SETTINGS_LOADED; source ~/.bashrc'
alias shp='unset BASH_ALIASES_LOADED BASH_PROFILE_LOADED TH3COD3_SETTINGS_LOADED; source ~/.bash_profile'
alias v='vim .'

alias ll='ls -lhF'
alias la='ls -lhAF'
alias l='ls -CF'

alias chmy='sudo chown -R th3cod3'
alias chdir='sudo find ./ -type d -print0 | xargs -0 chmod'
alias chfile='sudo find ./ -type f -print0 | xargs -0 chmod'
alias sh-all='chmy ./ && chdir 765 && chfile 644'

LARAVEL_FOLDERS="app bootstrap config database public resources routes storage tests"

alias perf="sudo find ${LARAVEL_FOLDERS} -type f -print0 | sudo xargs -0 chmod g+rw,u+rw,o+rw"
alias perd="sudo find ${LARAVEL_FOLDERS} -type d -print0 | sudo xargs -0 chmod 777"
alias perg="sudo chown -R th3cod3:www-data ${LARAVEL_FOLDERS}"
alias pera="perf; perd; perg"

# artisan
alias pa="php artisan"
alias pakey="php artisan key:generate"
alias pads="php artisan db:seed"
alias pamf="php artisan migrate:fresh"
alias pamfs="php artisan migrate:fresh --seed"
alias pam="php artisan migrate"
alias parl="php artisan route:list"
alias pat="php artisan test"
alias patf="php artisan test --filter"

#docker
alias dkup='docker-compose up -d --remove-orphans'
alias dku='docker-compose up -d --remove-orphans'
alias dkdown='docker-compose down'
alias dkd='docker-compose down'
alias dkstop='docker-compose stop'
alias dks='docker-compose stop'
alias dkstopa='docker container stop $(docker ps -q)'
alias dksa='docker container stop $(docker ps -q)'
alias dkfresh='docker-compose restart'
alias dkex='docker-compose exec'
alias dkps='docker-compose ps'
alias dklogs='docker-compose logs -f'
alias dkpsa='docker ps -a'
alias dkrma='docker rm $(docker ps -aq)'

alias dkdb='docker-compose exec db bash'
alias dkchrome='docker-compose exec chrome bash'
alias dknode='docker-compose exec node ash'
alias dkweb='docker-compose exec web bash'
alias dkw='docker-compose exec web bash'
alias dknr='docker-compose exec node-red bash'
alias dksw='docker-compose exec web sh'

### GIT
alias g='git'
alias gp='git pull'
alias gP='git push'
alias gPf='git push -f'
alias gPsu='git push -u origin HEAD'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcod='git checkout dev'
alias gcp='git cherry-pick'
alias gs='git status'
alias gss='git status -s'
alias ga='git add'
alias gai='git add -i'
alias gaA='git add -A'
alias gs='git stash'
alias gsl='git stash list'
alias gsa='git stash apply'
alias gsd='git stash drop'
alias gsp='git stash pop'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcA='git commit --amend --no-edit'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gd='git diff'
alias gr='git reset'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gb='git branch'
alias gbda='git branch | grep -v \* | xargs git branch -D ' # branch delete all except current
alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias grl='git reflog'
alias gu='git update-index --assume-unchanged'
alias gU='git update-index --no-assume-unchanged'

### TMUX
alias t="tmux new-session -As main"
alias tks="tmux -2 kill-server"
alias ts="~/.config/tmux/tmux-sessionizer.sh"

# ghidra
alias ghidra='~/src/ghidra_11.2_PUBLIC/ghidraRun'

export BASH_ALIASES_LOADED=1
