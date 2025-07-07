#!/bin/bash

sudo -v

# Set current username
USERNAME=$(whoami)

echo "[1/8] Updating package lists..."
sudo apt update

echo "[2/8] Installing required packages..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

echo "[3/8] Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "[4/8] Adding Docker's APT repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[5/8] Updating package lists again..."
sudo apt update

echo "[6/8] Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo "[7/8] Installing docker-compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "[8/8] Adding user to the docker group..."
sudo usermod -aG docker $USERNAME

echo
echo " Installation complete! Please run the following command to apply Docker group permissions (or log out and back in):"
echo "  ---> newgrp docker"
echo
echo " Test if Docker is working by running:"
echo "  ---> docker run hello-world"
echo
docker-compose --version
