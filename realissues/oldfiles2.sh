#!/bin/bash

source_directory="/tmp/"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d $source_directory ]; then

    echo -e "$R source directory is not found $source_directory"
    
fi

files_to_delete=$(find $source_directory -type f -mtime +14 -name "*.log")

while IFS= read -r line; do
    echo -e "$R deleting file is: $line"
    rm -rf $line
done <<< "$files_to_delete"
