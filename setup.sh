#! /bin/sh
set -e

# Create a sudo-enabled user
USER_PASSWD=$(openssl rand -base64 12)
useradd -m developer
echo "developer:${USER_PASSWD}" | chpasswd
usermod -aG sudo developer
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
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 
sudo apt update 
sudo apt install gh -y
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
