#!/bin/bash

# Declare Variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/var/backups/website"
LOGFILE="/var/log/site-backup.log"

# Make sure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Log
log(){
  echo "[%(date '+%d-%m-%Y %H:%M:%S')] $1" | sudo tee -a "LOGFILE" > /dev/null
}

# Create a new backup
log "Starting backup of $SOURCE_DIR..."
if [ -d "$SOURCE_DIR" ]; then
  BACKUP_FILE="$BACKUP_DIR/site-backup-%(date '+%d-%m-%Y %H:%M:%S').tar.gz"
  tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2>>"$LOGFILE"
  if [ $? -eq 0 ]; then
    log "Backup successful!: $BACKUP_FILE"
    else
    log "Backup failed during tar creation"
    exit 1
  fi
else
  log "Source directory $SOURCE_DIR does not exist. Backup cancelled"
  exit 1
fi

log "Backup script completed"
