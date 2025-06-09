#!/bin/bash

WEB_ROOT="/var/www/html"
BACKUP_DIR="/var/backups/website"
VERSION_FILE="$WEB_ROOT/VERSION.txt"
UPDATE_LOG="/var/log/site-update.log"
BACKUP_LOG="/var/log/site-backup.log"

echo "===== Website Status Report ====="
echo

# Current deployed version
if [ -f "$VERSION_FILE" ]; then
  echo "Current Deployed Version: "
  cat "$VERSION_FILE"
else
  echo "No VERSION.txt file found."
fi
echo

# Disk usage
echo "Disk Usage of Web Root ($WEB_ROOT):"
du -sh "$WEB_ROOT"
echo

# Last backup
echo "Last Backup: "
if [ -d "$BACKUP_DIR" ]; then
ls -lt "$BACKUP_DIR" | head -2
else
echo "Backup directory not found."
fi
echo

# Last 5 lines of most recent update log
echo "Recent Update Log Entries: "
if [ -f "$UPDATE_LOG" ]; then
  tail -5 "$UPDATE_LOG"
else
  echo "Update log not found."
fi 
echo

# Last 5 lines of most recent backup log
echo "Recent Backup Log Entries: "
if [ -f "$BACKUP_LOG" ]; then
  tail -5 "$BACKUP_LOG"
else
  echo "Backup log not found."
fi
echo

# Server Uptime
echo "Server Uptime: "
uptime
echo

echo "===== Website Status Report ====="
