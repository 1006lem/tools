#quickstart 

#사전설치
# 0. docker 설치
git clone https://github.com/boanlab/tools
cd tools
cd container
./install-docker.sh
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
echo "docker installed..." 
docker ps 

# 1. kind 
#https://kind.sigs.k8s.io/docs/user/quick-start/
#Installing From Release Binaries 🔗︎
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.19.0/kind-linux-amd64
chmod +x kind
sudo mv kind /usr/local/bin/kind
kind version


# 2. kubectl
#https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# validate (checksum)
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256" 
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

#install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

kubectl version --client

# 3. kn (knative CLI) 
# Knative resource(Services, Events Surces를 직접 YAML파일 작성 없이 쉽게 생성시킴)
#https://github.com/knative/client
# install kn
wget https://github.com/knative/client/releases/download/knative-v1.10.0/kn-linux-amd64

mv kn-linux-amd64 kn
chmod +x kn
sudo mv kn /usr/local/bin
kn version


#--------------------------------------------------------------------------
# Knative quickstart

sudo apt-get update
sudo apt-get install build-essential

# 1. install GO (gc Go compiler and tools)

#https://go.dev/dl/
#https://go.dev/doc/install/source
#https://velog.io/@standard2hsw/Go%EC%96%B8%EC%96%B4-%EB%B2%84%EC%A0%84-%EC%98%AC%EB%A6%AC%EA%B8%B0
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.20.4.linux-amd64.tar.gz
mkdir ~/go1.20.4

export GOROOT=/usr/local/go
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go1.20.4
source ~/.profile
go version


go version #1.20.4

# run knative quickstart plugin



