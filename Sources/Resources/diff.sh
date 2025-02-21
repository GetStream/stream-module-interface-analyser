#!/bin/bash

# Ensure script exits on first error
set -e

# Check for required Node.js package
PACKAGE="diff"

# Create a temporary directory for node_modules
TEMP_DIR=$(mktemp -d)
NODE_MODULES_DIR="$TEMP_DIR/node_modules"

# Cleanup function to remove temporary directory on exit
cleanup() {
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Install the required Node.js package in the temp directory
echo "Installing $PACKAGE in temporary directory..."
npm install $PACKAGE --prefix "$TEMP_DIR" --silent

# Check for correct usage
if [ "$#" -ne 4 ]; then
  echo "Usage: ./run-diff.sh <diff-script.sh> <file1> <file2> <outputFile>"
  exit 1
fi

# Run the Node.js diff script using the temp node_modules
NODE_PATH="$TEMP_DIR/node_modules" node $1 "$2" "$3" "$4"

# Temporary directory and node_modules will be cleaned up automatically
