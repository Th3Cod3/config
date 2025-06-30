#!/usr/bin/bash
if [ -f /etc/arch-release ]; then
  echo "Arch Linux detected"
  sudo pacman -Sy && sudo pacman -S --needed base-devel ninja gettext cmake unzip curl \
    php python go \
    npm python-pip \
    fzf tmux ripgrep git jq xclip
elif [ -f /etc/debian_version ]; then
  echo "Debian based distro detected"
  sudo apt update && \
    sudo apt install build-essential ninja-build gettext cmake unzip curl \
    php python3 golang \
    npm python3-pip cargo \
    fzf tmux ripgrep git jq xclip
else
  echo "Unsupported distro"
  exit 1
fi

ARCH=$(uname -m)

sudo npm i -g n
sudo n 22
sudo npm i -g typescript @vue/typescript-plugin

mkdir -p ~/.tmux
git submodule init
git submodule update

if [ -f /usr/local/bin/nvim ]; then
  echo "Neovim already installed"
else
  # compile neovim
  cd src/neovim
  rm -rf build
  make clean
  git fetch --tags --force
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

  # check if arm or x86 if arm set ARCH=armv6 otherwise ARCH=x86_64
  if [[ $ARCH == "aarch64" ]]; then
    ARCH=arm64
  fi

  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH}.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit
fi

if [ -f /usr/local/bin/lazysql ]; then
  echo "Lazysql already install"
else
  cd bin
  mkdir -p bin

  if [ -f lazysql.tar.gz ]; then
    rm lazysql.tar.gz
  fi

  # check if arm or x86 if arm set ARCH=armv6 otherwise ARCH=x86_64
  if [[ $ARCH == "aarch64" ]]; then
    ARCH=arm64
  fi

  curl -Lo lazysql.tar.gz "https://github.com/jorgerojas26/lazysql/releases/latest/download/lazysql_Linux_${ARCH}.tar.gz"
  tar xf lazysql.tar.gz lazysql
  sudo install lazysql /usr/local/bin
  rm lazysql.tar.gz lazysql
fi

if [ -f /usr/local/bin/lazydocker ]; then
  echo "Lazydocker already install"
else
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
  sudo install ~/.local/bin/lazydocker /usr/local/bin
fi

ln -sf ~/.config/config/tmux ~/.config/
ln -sf ~/.config/config/alacritty ~/.config/
ln -sf ~/.config/config/kitty ~/.config/
ln -sf ~/.config/config/nvim ~/.config/
ln -sf ~/.config/config/bash/.bash_aliases ~/.bash_aliases
ln -sf ~/.config/config/bash/.bash_profile ~/.bash_profile
ln -sf ~/.config/config/git/.gitconfig ~/.gitconfig
mkdir -p ~/.config/lazygit
ln -sf ~/.config/config/git/config.yml ~/.config/lazygit/config.yml

source ~/.bash_profile

