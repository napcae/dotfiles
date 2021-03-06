# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# screen with x256 => https://gist.github.com/shawnbot/3277580
PATH="/usr/local/bin:$PATH"
# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH=/usr/local/Cellar/ruby/2.0.0-p247/bin:/usr/local/bin:$(path_remove /usr/local/bin)
export PATH

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Make 'less' more.
##eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"

# Create a new Parallels VM from template, replacing the existing one.
#function vm_template() {
#  local name="$@"
#  local basename="$(basename "$name" ".zip")"
#  local dest_dir="$HOME/Documents/Parallels"
#  local dest="$dest_dir/$basename"
#  local src_dir="$dest_dir/Templates"
#  local src="$src_dir/$name"
#  if [[ ! "$name" || ! -e "$src" ]]; then
#    echo "You must specify a valid VM template from this list:";
#    for f in "$src_dir"/*.pvm "$src_dir"/*.pvm.zip; do
#      echo " * $(basename "$f")"
#    done
#    return 1
#  fi
#  if [[ -e "$dest" ]]; then
#    echo "Deleting old VM"
#    rm -rf "$dest"
#  fi
#  echo "Restoring VM template"
#  if [[ "$name" == "$basename" ]]; then
#    cp -R "$src" "$dest"
#  else
#    unzip -q "$src" -d "$dest_dir" && rm -rf "$dest_dir/__MACOSX"
#  fi && \
#  echo "Starting VM" && \
#  open -g "$dest"
#}

# Export Localization.prefPane text substitution rules.
function txt_sub_backup() {
  local prefs=~/Library/Preferences/.GlobalPreferences.plist
  local backup=~/.dotfiles/conf/osx/NSUserReplacementItems.plist
  /usr/libexec/PlistBuddy -x -c "Print NSUserReplacementItems" "$prefs" > "$backup" &&
  echo "File ~${backup#$HOME} written."
}

# Import Localization.prefPane text substitution rules.
function txt_sub_restore() {
  local prefs=~/Library/Preferences/.GlobalPreferences.plist
  local backup=~/.dotfiles/conf/osx/NSUserReplacementItems.plist
  if [[ ! -e "$backup" ]]; then
    echo "Error: file ~${backup#$HOME} does not exist!"
    return 1
  fi
  cmds=(
    "Delete NSUserReplacementItems"
    "Add NSUserReplacementItems array"
    "Merge '$backup' NSUserReplacementItems"
  )
  for cmd in "${cmds[@]}"; do /usr/libexec/PlistBuddy -c "$cmd" "$prefs"; done
}


#OS X specified aliases
alias mou='open -a Mou '

#spotlight in terminal
alias search='mdfind '

#brew upgrade und update
alias bbb='brew upgrade && brew update'

#Links
vlc=/Applications/VLC.app/Contents/MacOS/
git=/Users/napcae/Documents/Git

alias chrome='open /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app '
alias et='rm -rf ~/.Trash/*'

#prepare for new machine
#add src directory for software from source
if ! [ -d /src ];
then
	echo "Provide sudo password for creating /src directory"
	for i in {3..0}; do echo -n "$i "; sleep 1; done; echo 
	sudo mkdir -v /src
fi

#http://docs.mopidy.com/en/latest/installation/#installationexport PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHhttp://docs.mopidy.com/en/latest/installation/#installationexport PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATHONPATH
export PYTHONPATH=$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH
eval $(docker-machine env default)
