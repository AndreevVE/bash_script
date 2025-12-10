#!/bin/bash

read -p "Enter path to directory: " CHECKDIR
read -p "Enter file age in days (e.g., 7): " CHECKAGE

FILES=$(find "$CHECKDIR" -type f -mtime "$CHECKAGE")

if [ -z "$FILES" ]; then
    echo "No files older than $CHECKAGE days found."
    exit 0
fi

echo "Files found:"
echo "$FILES"

read -p "Delete these files? (yes/no): " ANSWER

if [ "$ANSWER" = "yes" ]; then
    for file in $FILES; do
        rm -rf "$file"
        echo "Deleted: $file"
    done
else
    echo "Canceled."
    exit 0
fi
