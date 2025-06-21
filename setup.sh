#! /bin/sh
set -e

# Update 
apt update -y

# Install Git
apt install git -y

# Update Docker
apt-get update
apt-get install docker-compose-plugin
docker compose version

# Setup Swap
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
free -h
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
echo "----------------------------------------------------------------"
echo -e "\nAllocated swap file"
echo "----------------------------------------------------------------"

# Install GitHub CLI
apt update -y
apt install git -y
git --version
curl -Lso /var/tmp/gh.deb "https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.deb"
dpkg -i /var/tmp/gh.deb
rm /var/tmp/gh.deb
gh --version
echo "----------------------------------------------------------------"
echo -e "\nInstalled GitHub CLI"
echo "----------------------------------------------------------------"

# Clean up
rm ./setup.sh
echo "----------------------------------------------------------------"
echo -e "\nInstallation completed!"
echo "----------------------------------------------------------------"
