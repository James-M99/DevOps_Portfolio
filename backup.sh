#!/bin/bash

# Declare Variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/var/backups/website"
TIMESTAMP=$(date +"%d-%m-%Y_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/site-backup-$TIMESTAMP.tar.gz"

# Make sure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Create a new backup
echo "Creating new backup of $SOURCE_DIR..."
sudo tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

# Check that backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successful!: $BACKUP_FILE"
else
  echo "Backup failed"
  exit 1
fi
