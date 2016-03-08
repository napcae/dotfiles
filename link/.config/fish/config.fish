function reload
    source ~/.config/fish/config.fish
end

begin
    set --local AUTOJUMP_PATH /usr/local/share/autojump/autojump.fish
    if test -e $AUTOJUMP_PATH
        source $AUTOJUMP_PATH
    end
end
rvm default

function subl
    open -a "Sublime Text 2.app" $argv
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

set -x GOPATH $HOME/go
set -x PATH $HOME/go/bin $PATH

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
