#!/bin/bash

# Exit if any command fails
set -e

# Define Variables
REPO_URL="https://github.com/James-M99/DevOps_Portfolio.git"
TARGET_DIR="/var/www/html"
BACKUP_DIR="/var/www/html_backup_$(date +%Y%m%d%H%M%S)"

# Clone or pull latest from GitHub
if [ -d /tmp/portfolio-site ]; then
  echo "Updating existing repo..."
  cd /tmp/portfolio-site
  git pull
else
  echo "Cloning repo..."
  git clone $REPO_URL /tmp/portfolio-site
fi

# Backup current site
echo "Backing up existing site to $BACKUP_DIR"
sudo cp -r $TARGET_DIR $BACKUP_DIR

# Deploy new site
echo "Deploying new site..."
sudo cp -r /tmp/portfolio-site/* $TARGET_DIR

# Set Permissions
sudo chown -R www-data:www-data $TARGET_DIR
sudo chown -R 755 $TARGET_DIR

# Restart Apache
echo "Restarting Apache..."
sudo systemctl restart apache2
echo "Deployment Complete!"
