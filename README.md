
# vscale-docker-env-setup

Bash script that installs PostgreSQL, GitHub CLI and creates 4Gb swap partition

## Installation

Run script with `wget`

```bash
wget https://raw.githubusercontent.com/borisevstratov/vscale-docker-env-setup/main/setup.sh && chmod +x setup.sh && ./setup.sh
```

## Post-installation

Authenticate GitHub CLI with

```bash
echo -n "$GITHUB_AUTH_TOKEN" | gh auth login --with-token
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
