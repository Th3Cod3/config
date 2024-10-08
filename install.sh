#!/usr/bin/bash
sudo apt update && \
  sudo apt install build-essential ninja-build gettext cmake unzip curl \
  php python3 openjdk-21-jre npm \
  fzf tmux ripgrep git

sudo npm i -g n
sudo n 22

rm ~/.config/tmux ||:
rm ~/.config/nvim ||:
rm ~/.bash_profile ||:
rm ~/.bash_aliases ||:
rm ~/.tmux.conf ||:
rm ~/.config/lazygit/config.yml ||:
rm -R ~/.tmux/plugins ||:

mkdir -p ~/.tmux
git submodule init
git submodule update

if [ -f src/neovim/build/bin/nvim ]; then
  echo "Neovim already installed"
else
  # compile neovim
  cd src/neovim
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ../..
fi

if [ -f ~/.git-completion.bash ]; then
  echo "Git completion already installed"
else
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

if [ -f /usr/local/bin/lazygit ]; then
  echo "Lazygit already install"
else
  cd bin
  mkdir -p bin

  if [ -f lazygit.tar.gz ]; then
    rm lazygit.tar.gz
  fi

  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
fi

ln -s ~/.config/config/tmux ~/.config/tmux
ln -s ~/.config/config/nvim ~/.config/nvim
ln -s ~/.config/config/bash/.bash_aliases ~/.bash_aliases
ln -s ~/.config/config/bash/.bash_profile ~/.bash_profile
ln -s ~/.config/config/git/config.yml ~/.config/lazygit/config.yml
ln -s ~/.config/config/tmux/plugins ~/.tmux/plugins

source ~/.bash_profile

