#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE( ) {
    if [ $? -ne 0 ]; then

        echo -e " $R ERROR...!$2........ is FAILED $N"
        exit 1
    else

        echo -e " $G SUCCESS..! $2............ is SUCCESS $N"

    fi
}

if [ $ID -ne 0 ]; then

    echo -e " $R ERROR....! YOU are NOT a ROOT USER $N "
    exit 1

else

    echo -e " $G SUCCESS...! YOU are ROOT USER..PLEASE PROCCED $N "

fi

dnf install -y https://rpms.remirepo.net/enterprise/8/remi/x86_64/remi-release-8.4-1.el8.remi.noarch.rpm
 &>> $logfile

VALIDATE $? "DOWNLOAD redis rpm file"

dnf module enable redis:remi-6.2 -y &>> $logfile

dnf module reset redis -y &>> $logfile

dnf module enable redis:remi-6.2 -y &>> $logfile
 
VALIDATE $? "enabeling redis rpm file"

dnf install redis -y &>> $logfile

VALIDATE $? "installing redis rpm file"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf &>> $logfile

VALIDATE $? "modifying the IP address"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf &>> $logfile

VALIDATE $? "Modifying the redis ip address in conf file"

systemctl enable redis &>> $logfile

VALIDATE $? "enabeling redis service"

systemctl start redis &>> $logfile

VALIDATE $? "starting the redis service"