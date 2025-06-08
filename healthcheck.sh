#!/bin/bash

# Output file
LOGFILE="$HOME/healthcheck.log"

log() {
  echo "[$(date '+%d-%m-%Y %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

log "===== STARTING HEALTH CHECK ====="

# Check if website responds
SITE_URL="http://localhost"
if curl --silent --head --fail "$SITE_URL" > /dev/null; then
  log "Website is responding"
  else
  log "Website is not responding"
fi

# Check if index.html exists
WEB_ROOT="/var/www/html"
if [ -f "$WEB_ROOT/index.html" ]; then
  log "index.html exists in $WEB_ROOT."
  else
  log "index.html is missing in $WEB_ROOT!"
fi

# Disk Space Usage
log "Checking disk usage..."
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}')
log "Disk usage is at root (/): $DISK_USAGE"

# Internet Connectivity
log "Checking for internet connectivity..."
if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
  log "Internet is connected!"
  else
  log "Internet is not connected!"
fi

# Currently deployed version
VERSION_FILE="$WEB_ROOT/VERSION.txt"
if [ -f "#$VERSION_FILE" ]; then
  VERSION=$(cat "$VERSION_FILE")
  log "Deployed version: $VERSION"
  else
  log " VERSION.txt not found!"
fi

log "===== END HEALTH CHECK ====="
