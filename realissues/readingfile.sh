#!/bin/bash

file="/etc/passwd"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -f $file ]; then

    echo -e "$R Target file is not found: $file"

fi

while IFS=":" read -r username passwd user_id group_id user_filenmae group_filename shell_path; do

    echo -e " username: $username "
    echo -e " passwd: $passwd "
    echo -e " user-id: $user_id "
done < "$file"