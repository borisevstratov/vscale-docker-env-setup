#! /bin/sh
set -e

# Install git
apt install git -y

# Update docker
sudo apt-get update
sudo apt-get install docker-compose-plugin
docker compose version

# Setup Swap
fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "----------------------------------------------------------------"
echo "\nAllocated swap file"
echo "----------------------------------------------------------------"

# Install GitHub CLI
sudo apt update -y
sudo apt install git -y
git --version
curl -Lso /var/tmp/gh.deb "https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.deb"
sudo dpkg -i /var/tmp/gh.deb
rm /var/tmp/gh.deb
gh --version
echo "----------------------------------------------------------------"
echo "\nInstalled GitHub CLI"
echo "----------------------------------------------------------------"

# Clean up
rm ./pico.sh
echo "----------------------------------------------------------------"
echo "\nInstallation completed!"
echo "----------------------------------------------------------------"
