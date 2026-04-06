#!/usr/bin/bash

usage() {
  cat <<'EOF'
Usage: ./install.sh [COMPONENT]
       ./install.sh nvim --update

If no component is provided, all components are installed.

Components:
  nvim
  git-completion
  lazygit
  lazysql
  lazydocker
  lazy-docker         Alias for lazydocker

Options:
  --update            Force update/reinstall Neovim
  -h, --help          Show this help message
EOF
}

normalize_component() {
  case "$1" in
  nvim | git-completion | lazygit | lazysql | lazydocker)
    printf '%s\n' "$1"
    return 0
    ;;
  lazy-docker)
    printf 'lazydocker\n'
    return 0
    ;;
  *)
    return 1
    ;;
  esac
}

TARGET=all
UPDATE_NVM=false

while [[ $# -gt 0 ]]; do
  case "$1" in
  -h | --help)
    usage
    exit 0
    ;;
  --update)
    UPDATE_NVM=true
    shift
    ;;
  *)
    if normalized=$(normalize_component "$1"); then
      if [[ "$TARGET" != "all" && "$TARGET" != "$normalized" ]]; then
        echo "Only one component can be selected"
        usage
        exit 1
      fi
      TARGET="$normalized"
      shift
    else
      echo "Unknown argument: $1"
      usage
      exit 1
    fi
    ;;
  esac
done

if [[ "$UPDATE_NVM" == "true" && "$TARGET" != "all" && "$TARGET" != "nvim" ]]; then
  echo "--update can only be used with nvim"
  usage
  exit 1
fi

should_install() {
  local component="$1"
  [[ "$TARGET" == "all" || "$TARGET" == "$component" ]]
}

if should_install all; then
  if [ -f /etc/arch-release ]; then
    echo "Arch Linux detected"
    sudo pacman -Sy && sudo pacman -S --needed base-devel ninja gettext cmake unzip curl \
      php python go \
      npm python-pip \
      fzf tmux ripgrep git jq xclip
  elif [ -f /etc/debian_version ]; then
    echo "Debian based distro detected"
    sudo apt update &&
      sudo apt install build-essential ninja-build gettext cmake unzip curl \
        php python3 golang \
        npm python3-pip cargo \
        fzf tmux ripgrep git jq xclip
  else
    echo "Unsupported distro"
    exit 1
  fi
fi

ARCH=$(uname -m)

if should_install all; then
  sudo npm i -g n
  sudo n 22
  sudo npm i -g typescript @vue/typescript-plugin
fi

if should_install all; then
  mkdir -p ~/.tmux
  git submodule init
  git submodule update
fi

if should_install nvim; then
  if [[ "$UPDATE_NVM" == "true" ]]; then
    echo "Updating Neovim"
    sudo rm -rf /usr/local/bin/nvim
  fi

  if [ -f /usr/local/bin/nvim ]; then
    echo "Neovim already installed"
  else
    # compile neovim
    cd src/neovim
    rm -rf build
    make distclean
    make deps CMAKE_BUILD_TYPE=RelWithDebInfo
    git fetch --tags --force
    git checkout stable --force
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    cd ../..
  fi
fi

if should_install git-completion; then
  if [ -f ~/.git-completion.bash ]; then
    echo "Git completion already installed"
  else
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
  fi
fi

if should_install lazygit; then
  if [ -f /usr/local/bin/lazygit ]; then
    echo "Lazygit already install"
  else
    mkdir -p bin
    cd bin

    if [ -f lazygit.tar.gz ]; then
      rm lazygit.tar.gz
    fi

    # check if arm or x86 if arm set ARCH=armv6 otherwise ARCH=x86_64
    LAZYGIT_ARCH="$ARCH"
    if [[ $LAZYGIT_ARCH == "aarch64" ]]; then
      LAZYGIT_ARCH=arm64
    fi

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
    cd ..
  fi
fi

if should_install lazysql; then
  if [ -f /usr/local/bin/lazysql ]; then
    echo "Lazysql already install"
  else
    mkdir -p bin
    cd bin

    if [ -f lazysql.tar.gz ]; then
      rm lazysql.tar.gz
    fi

    # check if arm or x86 if arm set ARCH=armv6 otherwise ARCH=x86_64
    LAZYSQL_ARCH="$ARCH"
    if [[ $LAZYSQL_ARCH == "aarch64" ]]; then
      LAZYSQL_ARCH=arm64
    fi

    curl -Lo lazysql.tar.gz "https://github.com/jorgerojas26/lazysql/releases/latest/download/lazysql_Linux_${LAZYSQL_ARCH}.tar.gz"
    tar xf lazysql.tar.gz lazysql
    sudo install lazysql /usr/local/bin
    rm lazysql.tar.gz lazysql
    cd ..
  fi
fi

if should_install lazydocker; then
  if [ -f /usr/local/bin/lazydocker ]; then
    echo "Lazydocker already install"
  else
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    sudo install ~/.local/bin/lazydocker /usr/local/bin
  fi
fi

if [[ "$TARGET" == "all" ]]; then
  ln -sf ~/.config/config/tmux ~/.config/
  ln -sf ~/.config/config/alacritty ~/.config/
  ln -sf ~/.config/config/kitty ~/.config/
  ln -sf ~/.config/config/nvim ~/.config/
  ln -sf ~/.config/config/bash/.bash_aliases ~/.bash_aliases
  ln -sf ~/.config/config/bash/.bash_profile ~/.bash_profile
  ln -sf ~/.config/config/bash/.inputrc ~/.inputrc
  ln -sf ~/.config/config/git/.gitconfig ~/.gitconfig
  mkdir -p ~/.config/lazygit
  ln -sf ~/.config/config/git/config.yml ~/.config/lazygit/config.yml

  source ~/.bash_profile
fi
