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
set -gx PATH ~/code/cf-aws-login/bin ~/code/cf-infra-stacks/bin $PATH

export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
export PATH="$PATH:$HOME/go/bin:$HOME/.okta/bin/"
status --is-interactive; and source (rbenv init -|psub)

export LIBRATO_TOKEN=(cat ~/.librato/token)
export GITHUB_OATH=(cat ~/.github-token)
export OKTA_API_KEY=(cat ~/.okta-token)
export HOMEBREW_GITHUB_API_TOKEN=(cat ~/.HOMEBREW_GITHUB_API_TOKEN)

export OKTA_STS_DURATION=28800
export OKTA_USERNAME=trung@contentful.com
export OKTA_MFA_CHOICE=OKTA.push

export CF_EMAIL="trung@contentful.com"
export DOCKER_REGISTRY=806120774687.dkr.ecr.us-east-1.amazonaws.com

alias ks="kubectl"
set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths
direnv hook fish | source
