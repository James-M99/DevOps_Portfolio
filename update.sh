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
  rm -rf "$TMP_DIR"
fi

# Clone latest version from GitHub
log "Cloning latest version of repository..."
git clone "$REPO_URL" "$TMP_DIR"

if [ $? -ne 0 ]; then
  log "Git clone failed. Update cancelled"
  exit 1
fi

# Tag main Git repository
if [ -d "$MAIN_REPO_DIR/.git" ]; then
    log "Tagging main repository at $MAIN_REPO_DIR"
    cd "$MAIN_REPO_DIR" || { log "Failed to cd into $MAIN_REPO_DIR"; exit 1}
    git tag "$VERSION" 2>&1 | tee -a "$LOGFILE"

if git tag | grep -q "$VERSION"; then
      log "Tag successfully created: $VERSION"
  else
      log "Failed to create Git tag."
fi
else
    log "ERROR: $MAIN_REPO_DIR is not a valid Git repository."
fi

# Backup Current website
mkdir -p "$BACKUP_DIR"
BACKUP_FILE="$BACKUP_DIR/site-backup-$VERSION.tar.gz"
tar -czf "$BACKUP_FILE" -C "$WEB_ROOT" .
log "Backup created at $BACKUP_FILE"

# Deploy new files
log "Deploying new files..."
rm -rf "$WEB_ROOT"/*
cp -r "$TMP_DIR"/* "$WEB_ROOT"/

# Add VERSION.txt file
echo "$VERSION" > "$WEB_ROOT/VERSION.txt"
log "Version $VERSION deployed and written to VERSION.txt"

# Set Permissions
log "Setting permissions..."
chown -R www-data:www-data "$WEB_ROOT"

log "Website update complete!"
