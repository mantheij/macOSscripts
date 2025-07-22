#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_DIR="./launchd"
TARGET_DIR="$HOME/Library/LaunchAgents"

if ! tccutil check Accessibility; then
  echo "Bitte erteile Terminal in Systemeinstellungen > Datenschutz > Bedienungshilfen die erforderlichen Rechte."
  echo "Öffne Systemeinstellungen und aktiviere die Berechtigungen, dann starte die Installation erneut."
  exit 1
fi

mkdir -p "$TARGET_DIR"

echo "Gefundene Plists:"
ls "$PLIST_DIR"/*.plist

for file in "$PLIST_DIR"/*.plist; do
    LABEL=$(basename "$file" .plist)
    echo "Installing $LABEL..."

    cp "$file" "$TARGET_DIR/"
    sed -i '' "s|__SCRIPT_PATH__|$SCRIPT_DIR|g" "$TARGET_DIR/$(basename "$file")"
    sed -i '' "s|__HOME__|$HOME|g" "$TARGET_DIR/$(basename "$file")"

    if launchctl list | grep -q "$LABEL"; then
        echo "Reloading $LABEL..."
        launchctl unload "$TARGET_DIR/$LABEL.plist"
    fi

    echo "Loading $LABEL..."
    launchctl load "$TARGET_DIR/$LABEL.plist"
done

echo "Installation successful."