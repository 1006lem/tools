#!/bin/bash

# Check operating system
if [[ $(uname -s) != "Linux" ]]; then
    echo "This script is for Linux."
    exit 1
fi

# 1. install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# activate nvm
source ~/.bashrc 

#check installization
nvm -v 


# 2. install node.js + npm
lts_version = $(nvm ls-remote --lts)
latest_lts_version = 
nvm install 18.16.0

#nvm install 16.20.0 
#use 18.16.0 으로 바꿀 수 있음


# 3. 



