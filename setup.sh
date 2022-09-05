#! /bin/sh
set -e

# Create a sudo-enabled user
USER_PASSWD=$(openssl rand -base64 12)
sudo groupadd docker
useradd -m developer
echo "developer:${USER_PASSWD}" | chpasswd
usermod -aG sudo developer
usermod -aG docker developer
echo "----------------------------------------------------------------"
echo "\nCreated sudo-user \nLogin: developer \nPassword: ${USER_PASSWD}"
echo "----------------------------------------------------------------"

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
sudo apt update -y
sudo apt install git -y
git --version
curl -Lso /var/tmp/gh.deb "https://github.com/cli/cli/releases/download/v2.14.6/gh_2.14.6_linux_amd64.deb"
sudo dpkg -i /var/tmp/gh.deb
rm /var/tmp/gh.deb
gh --version
echo "----------------------------------------------------------------"
echo "\nInstalled GitHub CLI"
echo "----------------------------------------------------------------"

# Install PostgreSQL
apt install postgresql postgresql-contrib -y
echo "----------------------------------------------------------------"
echo "\nInstalled PostgreSQL"
echo "----------------------------------------------------------------"

# Clean up
rm ./setup.sh
echo "----------------------------------------------------------------"
echo "\nInstallation completed!"
echo "----------------------------------------------------------------"
