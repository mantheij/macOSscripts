#!/bin/bash
fswatch -o ~/Downloads | while read; do
    ./moveImages.sh
done