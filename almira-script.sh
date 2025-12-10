#!/bin/bash

read -p "Enter the directory path: " DIR

if [[ ! -d "$DIR" ]]; then
    echo "Error: directory '$DIR' does not exist."
    exit 1
fi

read -p "Enter the file age in days: " DAYS

if ! [[ "$DAYS" =~ ^[0-9]+$ ]]; then
    echo "Error: age must be a number."
    exit 1
fi

FILES=$(find "$DIR" -type f -mtime +"$DAYS")

if [[ -z "$FILES" ]]; then
    echo "No files older than $DAYS days found."
    exit 0
fi

echo "The following files were found:"
echo "$FILES"
echo

read -p "Do you want to delete these files? (yes/no): " CONFIRM

if [[ "$CONFIRM" == "yes" ]]; then
    # Delete files
    echo "$FILES" | xargs rm -f
    echo "Files have been deleted."
else
    echo "Deletion canceled."
fi
