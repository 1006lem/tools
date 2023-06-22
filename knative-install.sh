#!/bin/bash

# Check operating system
if [[ $(uname -s) != "Linux" ]]; then
    echo "This script is for Linux."
    exit 1
fi

# Check architecture
if [[ $(uname -m) != "x86_64" ]]; then
    echo "This script is for amd64 architecture."
    exit 1
fi


# 0. install docker 
git clone https://github.com/boanlab/tools
cd tools/container
./install-docker.sh
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
echo "docker installed..." 
docker ps 

# 1. install kind 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.19.0/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind
kind version
echo "kind installed..." 


# 2. install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" 
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
echo "kubectl installed..." 

# 3. install kn (knative CLI) 
wget https://github.com/knative/client/releases/download/knative-v1.10.0/kn-linux-amd64
mv kn-linux-amd64 kn
chmod +x kn
sudo mv kn /usr/local/bin
kn version
echo "kn installed..." 


#--------------------------------------------------------------------------
# Knative quickstart

sudo apt-get update
sudo apt-get install build-essential

# 1. install GO (gc Go compiler and tools)
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.20.4.linux-amd64.tar.gz
mkdir ~/go1.20.4

export GOROOT=/usr/local/go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go1.20.4
source ~/.profile
go version
echo 'export PATH=$PATH:/home/kmkim/goroot/src/go/bin' >> ~/.bash_profile
echo 'export BASH_ENV=$HOME/.bashrc' >> ~/.bash_profile
echo 'export USERNAME="kmkim"' >> ~/.bash_profile
echo go version #1.20.4
echo "go installed..." 

# 2. install knative quickstart plugin
cd ~
git clone https://github.com/knative-sandbox/kn-plugin-quickstart.git
cd kn-plugin-quickstart
./hack/build.sh
chmod +x kn-quickstart
sudo mv kn-quickstart /usr/local/bin
kn quickstart --help
echo "kn quickstart plugin installed..." 

# 3. run the quickstart plugin
kn quickstart kind

# check if another service is using port 80
sudo netstat -tnlp | grep 80

# check if knative cluster exists
kind get clusters 

echo "complete!" 


