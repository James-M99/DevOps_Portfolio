#!/bin/bash

REPO_DIR="/home/ubuntu/DevOps_Portfolio"
VERSION="v$(date '+%d%m%Y-%H%M%S')"

echo "Changing to $REPO_DIR"
cd "$REPO_DIR" || { echo "Failed to cd into $REPO_DIR"; exit 1; }

echo "Current Git status:"
git status

echo "Creating tag: $VERSION"
git tag "$VERSION"

echo "Existing tags:"
git tag
