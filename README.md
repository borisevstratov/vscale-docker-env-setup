
# vscale-docker-env-setup

Bash script that installs PostgreSQL, GitHub CLI and creates 4Gb swap partition

## Installation

Run script with `wget`

```bash
wget https://raw.githubusercontent.com/borisevstratov/vscale-docker-env-setup/main/setup.sh && chmod +x setup.sh && ./setup.sh
```

or without creating a sudo-user and PostgreSQL db:

```bash
wget https://raw.githubusercontent.com/borisevstratov/vscale-docker-env-setup/main/pico.sh && chmod +x pico.sh && ./pico.sh
```

## Post-installation

Authenticate GitHub CLI with

```bash
export GH_TOKEN="$GITHUB_PAT"
gh auth setup-git
```

Authenticating to the Container registry

```bash
export CR_PAT="$GITHUB_PAT"
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

Create PostgreSQL user & database with

```bash
sudo -u postgres psql
```

```sql
CREATE ROLE $DB_USER WITH LOGIN PASSWORD '$DB_USER';
ALTER ROLE $DB_USER CREATEDB;
CREATE DATABASE $DB_NAME;

```
