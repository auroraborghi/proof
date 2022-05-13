#!/bin/bash
# Script to install all "first-time" only dependencies for this project.
# TODO: Go through and ensure that all these steps in the script works on a clean image!

# Deploy
# Install Docker dependencies.
sudo systemctl stop docker
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine

# Prune existing images.
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Set up Docker repositories.
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker engine (allow erasing to update dependencies on host):
sudo yum -y --allow-erasing install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-compose-plugin

# Start the Docker service and enable it on host startup:
sudo systemctl start docker
sudo systemctl enable docker

# Enable Use of Docker without Root
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl restart docker
sudo su $USER

# At this point test whether or not docker works using the information in the deploy README.

# Create elastic docker network and pull images for Elasticsearch and Kibana v7.14.2:
docker network create elastic
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.14.2
docker pull docker.elastic.co/kibana/kibana:7.14.2

# Install Python Backend
# Install Python system library dependencies.
sudo yum install -y \
    python3-devel \
    sqlite-devel \
    openssl-devel \
    libffi-devel

# Create Directory to Host Python Binaries
mkdir -p $HOME/Downloads/Python/
cd $HOME/Downloads/Python/

# Get Gzipped Source Tarball from Official Python Release
wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
tar -xzvf Python-3.10.4.tgz
cd Python-3.10.4.tgz

# Build Python 3.10.4 from Source
./configure --enable-optimizations
make
sudo make install

# Create the development virtual environment with dependencies installed and activate it.
make init
source .venv/proof/bin/activate

# Test this with 'ipython' in the terminal to ensure it worked.

# Create a Jupyter Kernel based on the virtual environment.
python -m ipykernel install --prefix=/home/aborghi/.local --name proof




