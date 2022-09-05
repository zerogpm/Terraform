#!/bin/bash

sudo apt update

sudo apt install software-properties-common

sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update

sudo apt install python3 -y

sudo apt install python3-pip -y

#sudo python3 -m pip install ansible

sudo apt-get install git