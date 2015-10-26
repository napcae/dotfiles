# Add binaries into the path
PATH=~/.dotfiles/bin:/usr/local/sbin:$PATH
export PATH

# Source all files in ~/.dotfiles/source/
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/.dotfiles/source/$1.sh"
  else
    for file in ~/.dotfiles/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}
if [[ $- =~ i ]]
then
    src
else
    export PS1="\u@\h \w> "
fi



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
