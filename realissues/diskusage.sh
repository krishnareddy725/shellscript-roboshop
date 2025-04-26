#!/bin/bash

DISK_USAGE=$(df -hT |grep -vE "tmp")
DISK_THRESHOLD=1
message= " "

while IFS= read line; do
    usage=$(df -hT |grep -vE "tmp"| awk '{print $6}'|cut -d % -f1)
    partion=$(df -hT |grep -vE "tmp"| awk '{print $1}')
    if [ $usage -gt $DISK_THRESHOLD ]; then
        message+= "High disk usage on $partion:$usage <br>"
    fi
done <<< $DISK_USAGE