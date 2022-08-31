#! /bin/sh
set -e

# Create a sude-enabled user
USER_PASSWD=$(openssl rand -base64 12)
useradd -m developer
echo "developer:${USER_PASSWD}" | chpasswd
usermod -aG sudo developer
echo "*** Created user 'developer' with password '${USER_PASSWD}' ***"

# Update dependencies
apt update -y
echo "*** Updated dependencies ***"

# Setup Swap
fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "*** Allocated swap file ***"

# Install GitHub CLI
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages
apt install gh -y
echo "*** Installed GitHub CLI ***"

# Install PostgreSQL
apt install postgresql postgresql-contrib -y
echo "*** Installed PostgreSQL ***"
