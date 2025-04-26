#!/bin/bash

SOURCE_DIR="/tmp/"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${R}Source directory is not available: $SOURCE_DIR${N}"
    exit 1
fi

FILES_TO_DELETE=$(find "$SOURCE_DIR" -type f -mtime +14 -name "*.tmp")

while IFS= read -r line; do
    echo -e "${R}Deleting file: $line${N}"
    rm -rf "$line"
done <<< "$FILES_TO_DELETE"
