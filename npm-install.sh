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

# check installization
nvm -v 

echo "nvm installed"


# 2. install node.js + npm
lts_version = $(nvm ls-remote --lts)
latest_lts_version=$(echo "$lts_versions" | grep -Eo 'v[0-9]+\.[0-9]+\.[0-9]+' | tail -n1)

if [ -z "$latest_lts_version" ]; then
  echo "No LTS versions available."
  exit 1
fi

echo "Installing the latest LTS version: $latest_lts_version"
nvm install "$latest_lts_version"

sudo apt-get update
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash --
sudo apt-get install -y nodejs
node -v
echo "node.js installed"


