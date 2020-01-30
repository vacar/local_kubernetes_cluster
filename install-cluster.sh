#!/usr/bin/env bash

##########################################################################################
#                                                                                        #
#                      This-script has been prepared by Vural Acar                       #
#                                                                                        #
##########################################################################################

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "Installing Docker Compose..........................."
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Installing Docker........................"
apt update
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt-cache policy docker-ce
apt install docker-ce

sleep 1

echo "Installing VirtualBox........................"
apt-get update
apt-get upgrade
echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
apt-get update
apt-get install virtualbox-6.0

sleep 1

echo "Installing kubectl..........................."
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

sleep 1

echo "Installing minikube..........................."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

mv minikube /usr/local/bin

sleep 1

echo "Please wait..........................."
sleep 2

kubectl version --client
minikube version
docker-compose version
docker version
