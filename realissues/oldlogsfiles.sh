### we have a folder where we are storing log files /tmp/shell-script-logs
### Delete the log files more than 14 days only .log extension not another file.

#!/bin/bash

source_directory="/tmp"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

files_to_delete=$(find source_directry -type f -mtime +14 -name "*.log")

while IFS= read -r line; do
    echo -e " delete file: $line"
    rm -rf $line
done <<< files_to_delete

