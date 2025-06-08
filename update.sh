#!/bin/bash

# Declare Variables
REPO_URL="https://github.com/James-M99/DevOps_Portfolio.git"
TMP_DIR="/tmp/portfolio-site-update"
WEB_ROOT="/var/www/html"
LOGFILE="/var/log/site-update.log"
BACKUP_DIR="/var/backups/website"
VERSION="v$(date '+%d%m%Y-%H%M%S')"
MAIN_REPO_DIR="/home/ubuntu/DevOps_Portfolio"

#Log Function
log() {
  echo "[$(date '+%d-%m-%Y %H:%M:%S')] $1" | tee -a "$LOGFILE"
  }

log "Starting website update..."

# Clean previous temp directory
if [ -d "$TMP_DIR" ]; then
  log "Removing old temporary directory..."
  sudo rm -rf "$TMP_DIR" || {
    log "ERROR: Failed to remove old temp directory"
    exit 1
    }
fi

# Clone latest version from GitHub
log "Cloning latest version of repository..."
git clone "$REPO_URL" "$TMP_DIR"
if [ $? -ne 0 ]; then
  log "Git clone failed. Update cancelled"
  exit 1
fi

#Update local working repository if it exists
if [ -d "$MAIN_REPO_DIR/.git" ]; then
  log "Pulling latest changes into $MAIN_REPO_DIR"
  cd "$MAIN_REPO_DIR"
  git reset --hard HEAD && git pull --rebase
else
  log "WARNING: $MAIN_REPO_DIR is not a Git repository. Skipping local repo update."
fi


# Create a local tag in the local repo (not pushed to GitHub)
if [ -d "$MAIN_REPO_DIR/.git" ]; then
  cd "$MAIN_REPO_DIR"
  git tag "$VERSION"
  log "Tag created in local repo: $VERSION"
fi

# Backup Current website
mkdir -p "$BACKUP_DIR"
BACKUP_FILE="$BACKUP_DIR/site-backup-$VERSION.tar.gz"
tar -czf "$BACKUP_FILE" -C "$WEB_ROOT" . || {
  log "ERROR: Failed to create backup!"
  exit 1
  }
log "Backup created at $BACKUP_FILE"

# Deploy new files
log "Deploying new files..."
rm -rf "$WEB_ROOT"/*
cp -r "$TMP_DIR"/* "$WEB_ROOT"/
if [ $? -eq 0 ]; then
  log "Files copied successfully to $WEB_ROOT"
else
  log "ERROR: Failed to copy files to $WEB_ROOT"
  exit 1
fi

# Add VERSION.txt file
echo "$VERSION" > "$WEB_ROOT/VERSION.txt"
log "Version $VERSION deployed and written to VERSION.txt"

# Reapply executable permissions to scripts
log "Restoring executable permissions..."
find "$WEB_ROOT" -name "*.sh" -exec chmod +x {} \;

# Set Permissions
log "Setting permissions..."
chown -R www-data:www-data "$WEB_ROOT"

log "Website update complete!"
