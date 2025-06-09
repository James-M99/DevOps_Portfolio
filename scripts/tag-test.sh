#!/bin/bash
# Define Variables
REPO_DIR="/home/ubuntu/DevOps_Portfolio"
VERSION="v$(date '+%d%m%Y-%H%M%S')"

# Change directory
echo "Changing to $REPO_DIR"
cd "$REPO_DIR" || { echo "Failed to cd into $REPO_DIR"; exit 1; }

# Get Git status
echo "Current Git status:"
git status

# Create a tag
echo "Creating tag: $VERSION"
git tag "$VERSION"

# Show existing tags
echo "Existing tags:"
git tag
