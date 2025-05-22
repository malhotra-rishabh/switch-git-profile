# Switch Git Profile

A simple bash script to easily switch between personal and work Git profiles, managing different SSH keys and Git configurations for different environments.

## Features

- Switch between personal and work Git profiles with a single command
- Automatically manages SSH keys
- Updates Git global configuration
- Maintains separate SSH configurations for different hosts

## Prerequisites

- Git installed on your system
- SSH key pairs for both personal and work accounts
- Access to GitHub and/or GitLab

## Setup Instructions

### 1. Generate SSH Keys

#### For Personal GitHub Account
```bash
# Generate a new ED25519 key for GitHub
ssh-keygen -t ed25519 -C "your.personal@email.com" -f ~/.ssh/id_ed25519_github
```

#### For Work GitLab Account
```bash
# Generate a new ED25519 key for GitLab
ssh-keygen -t ed25519 -C "your.work@email.com" -f ~/.ssh/id_ed25519_gitlab
```

### 2. Add SSH Keys to Your Accounts

#### For GitHub:
1. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519_github.pub
   ```
2. Go to GitHub → Settings → SSH and GPG keys → New SSH key
3. Paste your public key and give it a meaningful title
4. Click "Add SSH key"

#### For GitLab:
1. Copy your public key:
   ```bash
   cat ~/.ssh/id_ed25519_gitlab.pub
   ```
2. Go to GitLab → Preferences → SSH Keys
3. Paste your public key and give it a meaningful title
4. Click "Add key"

### 3. Configure the Script

1. Download the `switch_git_profile.sh` script
2. Make it executable:
   ```bash
   chmod +x switch_git_profile.sh
   ```
3. Edit the configuration section at the top of the script:
   ```bash
   # Personal GitHub config
   PERSONAL_NAME="Your Name"
   PERSONAL_EMAIL="your.personal@email.com"
   PERSONAL_KEY="$HOME/.ssh/id_ed25519_github"
   PERSONAL_HOST="github.com"

   # Work GitLab config
   WORK_NAME="Your Work Name"
   WORK_EMAIL="your.work@email.com"
   WORK_KEY="$HOME/.ssh/id_ed25519_gitlab"
   WORK_HOST="gitlab.company.com"
   ```

### 4. Create Aliases (Optional)

Add these aliases to your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
alias git-personal="~/path/to/switch_git_profile.sh personal"
alias git-work="~/path/to/switch_git_profile.sh work"
```

Then reload your shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc for Zsh
```

## Usage

### Using the Script Directly

```bash
# Switch to personal profile
./switch_git_profile.sh personal

# Switch to work profile
./switch_git_profile.sh work
```

### Using Aliases (if configured)

```bash
# Switch to personal profile
git-personal

# Switch to work profile
git-work
```

## What the Script Does

1. Updates your global Git configuration (name and email)
2. Configures SSH to use different keys for different hosts
3. Restarts the SSH agent with the appropriate key
4. Creates/updates your SSH config file

## Verification

After switching profiles, you can verify your current Git configuration:

```bash
git config --global user.name
git config --global user.email
ssh-add -l  # Lists active SSH keys
```

## Troubleshooting

If you encounter permission issues:
1. Ensure the script is executable: `chmod +x switch_git_profile.sh`
2. Check SSH key permissions: `chmod 600 ~/.ssh/id_ed25519*`
3. Check SSH config permissions: `chmod 600 ~/.ssh/config`

For SSH connection issues:
1. Test GitHub connection: `ssh -T git@github.com`
2. Test GitLab connection: `ssh -T git@gitlab.company.com`

## License

This project is open source and available under the MIT License.
