#!/bin/bash

PLIST_DIR="/launchd"
TARGET_DIR="$HOME/Library/LaunchAgents"

mkdir -p "$TARGET_DIR"

for file in "$PLIST_DIR"/.*plist; do
    LABEL=$(basename "$file" .plist)
    echo "Installing $LABEL..."

    cp "$file" "$TARGET_DIR/"

    if launchctl list | grep -q "$LABEL" then
        echo "Reloading $LABEL..."
        launchctl unload "$TARGET_DIR/$LABEL.plist"
    fi

    echo "Loading $LABEL..."
    launchctl load "$TARGET_DIR"/$LABEL.plist"
done

echo "Installation successful."