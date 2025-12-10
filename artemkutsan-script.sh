#!/bin/bash

read -p "Directory: " DIR
read -p "File age in days: " DAYS
read -p "Search depth (default 1): " DEPTH

if [ -z "$DEPTH" ]; then
    DEPTH=1
fi

FILES=$(find "$DIR" -maxdepth "$DEPTH" -type f -mtime +"$DAYS")

if [ -z "$FILES" ]; then
    echo "No files found"
    exit 0
fi

echo "Found:"
for file in $FILES; do
    echo "$file"
done

read -p "Delete? (yes/no): " ANSWER

case "$ANSWER" in
    (yes|Yes|y|Y)
        for file in $FILES; do
            rm -f "$file"
        done
        echo "Deleted"
        ;;
    (no|No)
        echo "Cancelled"
        ;;
    (*)
        echo "Invalid input"
        exit 1
        ;;
esac

