#!/bin/bash

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to the docker group
sudo usermod -aG docker $(whoami)

# Enable Docker service on startup
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Configure docker daemon
sudo cp ./daemon.json /etc/docker/daemon.json
sudo chmod 644 /etc/docker/daemon.json

# Enable remote API for the local network
sudo mkdir /etc/systemd/system/docker.service.d
sudo cp ./override.conf /etc/systemd/system/docker.service.d/override.conf

# Restart Docker service
sudo systemctl daemon-reload
sudo systemctl restart docker.service