#!/bin/bash
read -p "Enter path for control:" pathcheck
if [ ! -d "$pathcheck" ]; then
    echo "Error path not found"
    exit 1
fi
read -p "Enter path for summ:" pathsumm
mkdir -p "$pathsumm"
name_file=$pathsumm/$(basename "$pathcheck")-"md5summ.txt"

for file in "$pathcheck"/*; do
    if [ -f "$file" ]; then
        echo "Calculating MD5 checksum for $file"
        md5sum "$file" >> "$name_file"
    fi
done
echo "MD5 checksums have been saved to $name_file"
