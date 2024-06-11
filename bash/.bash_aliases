alias sh-r='source ~/.bashrc'
alias sh-rc='code ~/.bashrc'
alias sh-al='code ~/.bash_aliases'
alias sh-p='source ~/.bash_profile'

alias ll='ls -alF'
alias la='ls -A'
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
alias pa-key="php artisan key:generate"
alias pad-s="php artisan db:seed"
alias pam-f="php artisan migrate:fresh"
alias pam-fs="php artisan migrate:fresh --seed"
alias pam="php artisan migrate"
alias par-l="php artisan route:list"
alias pat="php artisan test"
alias pat-f="php artisan test --filter"
alias pmc="php artisan make:controller"
alias pmcmd="php artisan make:command"
alias pme="php artisan make:exception"
alias pmm="php artisan make:model"
alias pmrl="php artisan make:rule"
alias pmrq="php artisan make:request"
alias pmrs="php artisan make:resource"
alias pmt="php artisan make:test"
alias pmmi="php artisan make:migration"

#docker
alias dk-up='docker-compose up -d --remove-orphans'
alias dk-down='docker-compose down'
alias dk-stop='docker-compose stop'
alias dk-fresh='docker-compose restart'
alias dk-ex='docker-compose exec'
alias dk-ps='docker-compose ps'
alias dk-logs='docker-compose logs -f'
alias dk-stop-all='docker container stop $(docker ps -q)'
alias dk-ps-all='docker ps -a'
alias dk-rm-all='docker rm $(docker ps -aq)'

alias dk-rsi-db='docker-compose exec db mysql -padmin -D rsi'
alias dk-ti='docker-compose exec truckit_web_nginx bash'
alias dk-db='docker-compose exec db bash'
alias dk-chrome='docker-compose exec chrome bash'
alias dk-mweb='docker-compose exec mijnavia_web bash'
alias dk-auweb='docker-compose exec authavia_web bash'
alias dk-node='docker-compose exec node ash'
alias dk-db-sql='docker-compose exec db mysql'
alias dk-web='docker-compose exec web bash'
alias dk-aweb='docker-compose exec web sh'
alias dk-sh='docker-compose exec web sh'
alias dk-nodered='docker-compose exec node-red bash'

### GIT
alias g='git'
alias g-pl='git pull'
alias g-ps='git push'
alias g-psf='git push -f'
alias g-psu='git push -u origin HEAD'
alias g-c='git checkout'
alias g-cb='git checkout -b'
alias g-com='git checkout master'
alias g-cod='git checkout dev'
alias g-cp='git cherry-pick'
alias g-s='git status -s'
alias g-a='git add'
alias g-ai='git add -i'
alias g-aA='git add -A'
alias g-st='git stash'
alias g-stl='git stash list'
alias g-sta='git stash apply'
alias g-std='git stash drop'
alias g-stp='git stash pop'
alias g-cm='git commit -m'
alias g-m='git merge'
alias g-d='git diff'
alias g-r='git reset'
alias g-rh='git reset --hard'
alias g-rs='git reset --soft'
alias g-b='git branch'
alias g-bdelall='git branch | grep -v \* | xargs git branch -D '
alias g-l='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
alias g-rf='git reflog'