#!/bin/bash

# Define vars
REPO="https://github.com/your-username/your-repo.git"
DEST="/tmp/portfolio-site"
WEB_ROOT="/var/www/html"

# Check if destination exists
if [ -d "$DEST/.git" ]; then
    echo "Repo already exists. Pulling updates..."
    cd "$DEST" && git pull
else
    echo "Cloning fresh copy..."
    rm -rf "$DEST"
    git clone "$REPO" "$DEST"
fi

# Copy to web root
echo "Deploying to web root..."
sudo cp -r "$DEST"/* "$WEB_ROOT"

# Restart Apache
echo "Restarting Apache..."
sudo systemctl restart apache2

echo "Deployment complete."
