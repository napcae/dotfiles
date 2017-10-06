function reload
    source ~/.config/fish/config.fish
end

begin
    set --local AUTOJUMP_PATH /usr/local/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end

function subl
    open -a "Sublime Text.app" $argv
end

function chrome
   if count $argv > /dev/null
     /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $argv;
     open /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app
   else  
     open /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app
   end  
end

function google
   /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "http://www.google.de/search?q=$argv";
   open /opt/homebrew-cask/Caskroom/google-chrome/latest/Google\ Chrome.app
end


# Start or re-use a gpg-agent.
#
#gpgconf --launch gpg-agent

# Ensure that GPG Agent is used as the SSH agent
#set -e SSH_AUTH_SOCK
#set -U -x SSH_AUTH_SOCK ~/.gnupg/S.gpg-agent.ssh

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Gotham Shell
#eval sh $HOME/.config/gotham/gotham.sh

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
status --is-interactive; and source (rbenv init -|psub)
