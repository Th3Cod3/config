alias shr='source ~/.bashrc'
alias shp='source ~/.bash_profile'
alias shrc='vim ~/.bashrc'
alias shc='cd ~/.config/config; vim .'
alias shal='vim ~/.bash_aliases'

### Workspaces
alias vcfg='cd ~/.config/config; vim .'
alias vrsi='cd ~/code/Th3Cod3/RSI; vim .'

alias ll='ls -lhF'
alias la='ls -lhAF'
alias l='ls -CF'

alias sh-rp='sudo chown -R th3cod3 ./* -vvv && sudo find ./ -type d -print0 | xargs -0 chmod 755 -vvv && sudo find ./ -type f -print0 | xargs -0 chmod 644 -vvv'
alias per-lar-f='sudo find storage bootstrap/cache -type f -print0 | xargs -0 chmod g=rw,u+rw,o=r -vvv'
alias per-lar-d='sudo find storage bootstrap/cache -type d -print0 | xargs -0 chmod 775 -vvv'
alias per-lar-own='sudo chown -R :www-data storage bootstrap/cache -vvv'
alias chmy-l='sudo chown -R th3cod3 database app resources routes config public tests lang -vvv'
alias chmy='sudo chown -R th3cod3'
alias chdir='sudo find ./ -type d -print0 | xargs -0 chmod'
alias chfile='sudo find ./ -type f -print0 | xargs -0 chmod'
alias sh-all='chmy ./ && chdir 765 && chfile 644'

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
alias dkdown='docker-compose down'
alias dkstop='docker-compose stop'
alias dkfresh='docker-compose restart'
alias dkex='docker-compose exec'
alias dkps='docker-compose ps'
alias dklogs='docker-compose logs -f'
alias dkstopa='docker container stop $(docker ps -q)'
alias dkpsa='docker ps -a'
alias dkrma='docker rm $(docker ps -aq)'

alias dkrsidb='docker-compose exec db mysql -padmin -D rsi'
alias dkti='docker-compose exec truckit_web_nginx bash'
alias dkdb='docker-compose exec db bash'
alias dkchrome='docker-compose exec chrome bash'
alias dkmweb='docker-compose exec mijnavia_web bash'
alias dkauweb='docker-compose exec authavia_web bash'
alias dknode='docker-compose exec node ash'
alias dkdb-sql='docker-compose exec db mysql'
alias dkweb='docker-compose exec web bash'
alias dkaweb='docker-compose exec web sh'
alias dksh='docker-compose exec web sh'
alias dknodered='docker-compose exec node-red bash'

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
alias gm='git merge'
alias gd='git diff'
alias gr='git reset'
alias grh='git reset --hard'
alias grs='git reset --soft'
alias gb='git branch'
alias gbda='git branch | grep -v \* | xargs git branch -D ' # branch delete all except current
alias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias grl='git reflog'

### TMUX
alias t="tmux -2"
alias ta="tmux -2 a"
alias tat="tmux -2 a -t"
alias tks="tmux -2 kill-server"
