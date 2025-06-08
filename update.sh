#!/bin/bash

# Declare Variables
REPO_URL="https://github.com/James-M99/DevOps_Portfolio.git"
TMP_DIR="/tmp/portfolio-site-update"
WEB_ROOT="/var/www/html"
LOGFILE="/var/log/site-update.log"

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

# Backup Current website
BACKUP_DIR="/var/backups/website"
mkdir -p "$BACKUP_DIR"
BACKUP_FILE="$BACKUP_DIR/site-backup-update-$(date '+%d-%m-%Y_%H-%M-%S').tar.gz"
tar -czf "$BACKUP_FILE" -C "$WEB_ROOT" .
log "Backup of current site saved to $BACKUP_FILE"

# Deploy new files
log "Deploying new files..."
rm -rf "$WEB_ROOT"/*
cp -r "$TMP_DIR"/* "$WEB_ROOT"/

# Set Permissions
log "Setting permissions..."
chown -R www-data:www-data "$WEB_ROOT"

log "Website update complete!"
