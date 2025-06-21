
# vscale-docker-env-setup

Bash script that installs Docker, GitHub CLI and creates 4Gb swap partition

## Installation

Run script with `wget`

```bash
wget https://raw.githubusercontent.com/borisevstratov/vscale-docker-env-setup/main/setup.sh && chmod +x setup.sh && ./setup.sh
```

## Post-installation

Authenticate GitHub CLI with

```bash
export GH_TOKEN="$GITHUB_PAT"
gh auth setup-git
```

Authenticating to the Container registry

```bash
echo $GH_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
```
