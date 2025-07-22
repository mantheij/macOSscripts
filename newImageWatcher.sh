#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

fswatch -o ~/Downloads | while read; do
    "$SCRIPT_DIR/moveImages.sh"
done