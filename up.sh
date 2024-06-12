rm ~/.config/tmux ||:
rm ~/.config/nvim ||:
rm ~/.bash_profile ||:
rm ~/.bash_aliases ||:

ln -s ~/.config/config/tmux ~/.config/tmux
ln -s ~/.config/config/nvim ~/.config/nvim
ln -s ~/.config/config/bash/.bash_aliases ~/.bash_aliases
ln -s ~/.config/config/bash/.bash_profile ~/.bash_profile
