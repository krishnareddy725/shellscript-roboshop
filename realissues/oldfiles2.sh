#!/bin/bash

source_dir="/tmp/"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d "$source_dir" ]; then

    echo -e " $R source directory is not avilable : $source_dir"
    exit 1
fi

files_to_delete=$(find $source_dir -type f -mtime +14 -name "*.log")
while IFS= read -r line; do
    echo -e " $R File going to be delete is $N:-" "$line"
    rm -rf "$line"
done <<< "$files_to_delte"
