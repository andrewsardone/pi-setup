#!/usr/bin/env bash

sudo apt-get update && sudo apt-get upgrade
sudo apt-get dist-upgrade

# minor dependencies
sudo apt-get install \
	git \
	libffi-dev \
	libssl-dev \
	python3-dev \
	python3-distutils \
	tmux \
	vim

# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker pi

# install docker-compose
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && sudo python3 get-pip.py
sudo pip3 install docker-compose
