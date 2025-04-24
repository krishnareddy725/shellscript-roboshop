### we have a folder where we are storing log files /tmp/shell-script-logs
### Delete the log files more than 14 days only .log extension not another file.

#!/bin/bash

Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

source_directory="/tmp"

if [ ! -d $source_directory ]; then

    echo -e " $R Source directory: $source_directory does not exist $N "

fi

files_to_delete=$(find $source_directory -type f -mtime +14 -name "*.txt")

while IFS=read -r line
do
    echo "deleting files: $line"
    rm -rf $line
done <<< $files_to_delete
