#!/bin/bash -eux
IFS=$'\n\t'

[[ $PATH != *$HOME/bin* ]] && PATH=$PATH:~/bin
[[ $PATH != *$HOME/Library/Python/2.7/bin* ]] && PATH=$PATH:~/Library/Python/2.7/bin
PYTHONPATH=/usr/bin/python

BIO_PATH="$HOME/wanderbee/beeswaxio"

# shellcheck disable=SC1090
source ~/.git-completion.bash
# shellcheck disable=SC1090
source ~/.git-prompt.sh

# Colors
green="\\[\\033[0;32m\\]"
blue="\\[\\033[0;34m\\]"
purple="\\[\\033[0;35m\\]"
reset="\\[\\033[0m\\]"

# Change command prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
PS1="$purple\\u@\\h $blue\\W$green\$(__git_ps1)\\n$purple$ $reset"

NVM_DIR="$HOME/.nvm"
if [[ -s "/usr/local/opt/nvm/nvm.sh" ]]; then
    # shellcheck disable=SC1091
    source /usr/local/opt/nvm/nvm.sh
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # shellcheck disable=SC1090
    source "$NVM_DIR/nvm.sh"
else
    echo "No nvm.sh file found in /usr/local/opt/nvm/ or $NVM_DIR/nvm.sh"
fi

PYTHONDONTWRITEBYTECODE=1
HISTTIMEFORMAT="%d/%m/%y %T "

export PS1
export PATH
export NVM_DIR
export PYTHONPATH
export HISTTIMEFORMAT
export GIT_PS1_SHOWDIRTYSTATE
export GIT_PS1_SHOWSTASHSTATE
export PYTHONDONTWRITEBYTECODE

# Config profiles
function prof {
    if [[ "$1" == "code" ]]; then
        code ~/.bash_profile
    else
        vim ~/.bash_profile
    fi
}
function gitprof {
    vim ~/.gitconfig
}
function reprof {
    # shellcheck disable=SC1090
    source ~/.bash_profile
}
function vimprof {
    vim ~/.vimrc
}
function setup {
    local setup_path="$HOME/Desktop/dev/setup"
    if [[ ! -d "$setup_path" ]]; then
        echo "$setup_path doesn't exist"
    else
        cd "$setup_path"
    fi
}
function bp {
    setup
    git pull
    reprof
    cd -
}

# Dirs
function sbx {
    cd ~/Desktop/sandbox
}
function jd {
    local jd_path="$HOME/Desktop/dev/janetandderek"
    if [[ -d "$jd_path" ]]; then
        cd "$jd_path"
    else
        echo "$jd_path doesn't exist"
    fi
}
function wb {
    local wb_path="$HOME/wanderbee"
    if [[ -d "$wb_path" ]]; then
        cd "$wb_path"
    else
        echo "$wb_path doesn't exist"
    fi
}
function bw {
    if [[ -d "$BIO_PATH" ]]; then
        code "$BIO_PATH"
    else
        echo "Not mounted!"
    fi
}

# Apps
function workwork {
    open /Applications/Mail.app
    open /Applications/Slack.app
    open /Applications/Calendar.app
    open /Applications/Typora.app
    open /Applications/Spotify.app
    wb
}

# Commands
function npr {
    npm run "$1"
}
function tunnel {
    wb && vagrant ssh
}
function uvm {
    wb
    osascript -e 'quit app "Visual Studio Code"'
    vagrant sshfs --unmount
}

# Bind fzf bash history search to ctrl + r
bind "$(bind -s | grep '^"\\C-r"' | sed 's/"/"\\C-x/' | sed 's/"$/\\C-m"/')"

eval "$(thefuck --alias 2>/dev/null)"
