#! /bin/sh
set -e

# Update dependencies
apt update -y
echo "----------------------------------------------------------------"
echo "\nUpdated Linux dependencies"
echo "----------------------------------------------------------------"

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
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages
apt install gh -y
echo "----------------------------------------------------------------"
echo "\nInstalled GitHub CLI"
echo "----------------------------------------------------------------"

# Clean up
rm ./pico.sh
echo "----------------------------------------------------------------"
echo "\nInstallation completed!"
echo "----------------------------------------------------------------"
