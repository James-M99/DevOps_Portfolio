#!/bin/bash

# Declare Variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/var/backups/website"
LOGFILE="/var/log/site-backup.log"
MAX_BACKUPS=3
# Make sure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Log
log() {
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

# Clean up older backups
BACKUP_COUNT=$(ls -1t "$BACKUP_DIR"/site-backup-*.tar.gz | wc -l)

if [ "$BACKUP_COUNT" -gt "MAX_BACKUPS" ]; then
  TO_DELETE=$(ls -1t "$BACKUP_DIR"/site-backup-*.tar.gz | tall -n +$(($MAX_BACKUPS + 1)))
    for FILE in $TO_DELETE; do
    rm -f "$FILE"
    log "Deleted old backup: $FILE"
    done
fi
log "Backup script completed"
