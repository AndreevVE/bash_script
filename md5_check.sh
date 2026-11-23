#!/bin/bash
read -p "Enter path for control: " pathcheck
if [ ! -d $pathcheck ]
   then
       echo "Error Directory not found!"
       exit 1
fi

read -p "Enter path fo result file: " pathresult
mkdir -p $pathresult

name_file=$pathresult/$(basename $pathcheck)-"md5-sum.txt"
echo "File with resut - $name_file"

for file in "$pathcheck"/*
    do
      if [ -f $file ]
         then
             echo "file name - $file"
             md5sum "$file" >> "$name_file"
      fi
    done