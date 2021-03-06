# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245
if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
  sudo xcode-select -switch /usr/bin
fi

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  e_header "Installing Homebrew"
  true | /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
fi

# install brew cask if not installed yet
if [[ ! "$(brew cask)" ]]; then
  e_header "Installing Brew Cask"
  brew install brew-cask
  brew tap phinze/cask
fi

if [[ "$(type -P brew)" ]]; then
  e_header "Updating Homebrew"
  brew update

  # Install Homebrew recipes.
  recipes=(git\
   tree \
   jq \
   tldr \
   curl \
   wget \
   rbenv \
   lesspipe \
   irssi \
   screen \
   nmap \
   git-extras \
   htop-osx \
   mobile-shell \
   youtube-dl \
   ffmpeg \
   autojump \
   ansible \
   terraform \
   kubernetes-cli
   awscli \
   ykman \
   diff-so-fancy \
   prettyping \
   ncdu
   fd
   ack)

  list="$(to_install "${recipes[*]}" "$(brew list)")"
  if [[ "$list" ]]; then
    e_header "Installing Homebrew recipes: $list"
    brew install $list
  fi

  cask_recipes=(google-chrome \
    1password \
    flux \
    gpg-suite \
    keybase \
    docker \
    amethyst \
    keybase \
    sublime-text \
    macdown
    telegram \
    vlc \
    whatsapp \
    yate \
    nvalt
  )

  cask_list="$(to_install "${cask_recipes[*]}" "$(brew list)")"
  if [[ "$cask_list" ]]; then
    e_header "Installing Homebrew Cask recipes: $cask_list"
    brew cask install $cask_list
  fi
  

fi
