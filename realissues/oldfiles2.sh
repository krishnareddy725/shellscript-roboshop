/bin/bash

source_dir="/tmp/"

R="\e[31m"
G="\e[32m"
Y="\e[33m"

files_to_delete=$(find source_dir -type f -mtime +14 -type "*.log")
while IFS= read -r line; do
    echo -e "File going to be delete: $line"
    rm -rf $line
done <<< files_to_delte
