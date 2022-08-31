#! /bin/bash
set -x

# Read args
while getopts gh:pg:sw: flag; do
    case "${flag}" in
    gh) GITHUB_TOKEN=${OPTARG} ;;
    pg) POSTGRES_NAME=${OPTARG} ;;
    sw) SWAP_SIZE=${OPTARG} ;;
    esac
done

# Write credentials
echo "$GITHUB_TOKEN" >.githubtoken
unset GITHUB_TOKEN

# Update dependencies
apt update -y

# Install GitHub CLI
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
apt-add-repository https://cli.github.com/packages
apt update
apt install gh

# Login to Github CLI
gh auth login --with-token <.githubtoken
rm .githubtoken

# Install PostgreSQL
apt update -y
apt install postgresql postgresql-contrib -y

sudo -u postgres psql -c "CREATE ROLE $POSTGRES_NAME WITH LOGIN PASSWORD '$POSTGRES_NAME'"
sudo -u postgres psql -c "ALTER ROLE $POSTGRES_NAME CREATEDB"
sudo -u postgres psql -c "CREATE DATABASE $POSTGRES_NAME"

# Setup Swap
fallocate -l $SWAP_SIZE /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
