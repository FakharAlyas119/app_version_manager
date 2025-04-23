#!/bin/bash

# Make sure the script exits on any error
set -e

echo "Installing app_version_manager..."

# Activate the package globally
dart pub global activate --source path .

echo "✅ Installation complete!"
echo ""
echo "You can now use the version_bump command:"
echo "  version_bump major   - Increment major version"
echo "  version_bump minor   - Increment minor version"
echo "  version_bump patch   - Increment patch version"
echo "  version_bump build   - Increment build number only"
echo "  version_bump bump    - Smart version increment"
echo ""
echo "Make sure your Dart bin directory is in your PATH."