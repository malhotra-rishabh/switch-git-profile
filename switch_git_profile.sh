#!/bin/bash

# === CONFIGURE YOUR DETAILS BELOW ===

# Personal GitHub config
PERSONAL_NAME="Personal Name"
PERSONAL_EMAIL="Personal Email"
PERSONAL_KEY="$HOME/.ssh/id_ed25519_github"
PERSONAL_HOST="github.com"

# Work GitLab config
WORK_NAME="Work Name"
WORK_EMAIL="Work Email"
WORK_KEY="$HOME/.ssh/id_ed25519_gitlab"
WORK_HOST="gitlab.company.com"

# === END CONFIG ===

function update_git_identity() {
  git config --global user.name "$1"
  git config --global user.email "$2"
  echo "✅ Set Git global identity to: $1 <$2>"
}

function restart_ssh_agent_with_key() {
  ssh-add -D >/dev/null 2>&1
  eval "$(ssh-agent -s)"
  ssh-add "$1"
  echo "🔐 Using SSH key: $1"
}

function set_ssh_config() {
  cat > ~/.ssh/config <<EOF
Host $PERSONAL_HOST
  HostName $PERSONAL_HOST
  User git
  IdentityFile $PERSONAL_KEY
  IdentitiesOnly yes

Host $WORK_HOST
  HostName $WORK_HOST
  User git
  IdentityFile $WORK_KEY
  IdentitiesOnly yes
EOF
  chmod 600 ~/.ssh/config
  echo "🔧 Updated SSH config"
}

function usage() {
  echo "Usage: $0 [personal|work]"
  exit 1
}

if [ $# -ne 1 ]; then
  usage
fi

set_ssh_config

if [ "$1" == "personal" ]; then
  update_git_identity "$PERSONAL_NAME" "$PERSONAL_EMAIL"
  restart_ssh_agent_with_key "$PERSONAL_KEY"
elif [ "$1" == "work" ]; then
  update_git_identity "$WORK_NAME" "$WORK_EMAIL"
  restart_ssh_agent_with_key "$WORK_KEY"
else
  usage
fi