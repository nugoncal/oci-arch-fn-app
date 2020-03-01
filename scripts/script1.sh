#!/bin/bash
set -e -x

sudo echo "OCI CLI Install"

printf 'y\n' | sudo yum install python-pip
sudo pip install oci-cli --upgrade

# Installing the docker engine
sudo echo "Installing the docker engine"

sudo cd /etc/yum.repos.d/
sudo wget http://yum.oracle.com/public-yum-ol7.repo

sudo yum install docker-engine
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker

# fn install

sudo curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

sudo echo "Script run complete and exiting"
