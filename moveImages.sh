#!/bin/bash
find ~/Downloads -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec mv -n {} ~/Pictures/ \;