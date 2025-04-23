#!/bin/bash

# Enable error handling
set -e

# Change to the script directory
SCRIPT_DIR="$(dirname "$0")"
echo "Changing to script directory: $SCRIPT_DIR"
cd "$SCRIPT_DIR" || exit 1

# Function to display usage
show_usage() {
    echo "Usage: ./bump_version.sh <command>"
    echo "Commands:"
    echo "  major   - Bump major version (x.0.0)"
    echo "  minor   - Bump minor version (0.x.0)"
    echo "  patch   - Bump patch version (0.0.x)"
    echo "  build   - Bump build number (+x)"
    echo "  bump    - Auto increment version following store guidelines"
}

# Check if command is provided
if [ -z "$1" ]; then
    show_usage
    exit 1
fi

echo "Running version manager with command: $1"
# Run version manager with provided command
dart app_version_manager.dart "$1" || { echo "Error running version manager"; exit 1; }