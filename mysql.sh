#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE( ) {

    if [ $? -ne 0 ]; then

        echo -e "$2..............is $R FAILED $N "
        exit 1

    else

        echo -e "$2 ............... is $G SUCCESS $N "

    fi
}

if [ $ID -ne 0 ]; then

    echo -e " $R You are NOT a root user $N "
    exit 1

else

    echo -e " $G you are a ROOT user..Please procced..!"

fi

dnf module disable mysql -y &>> $logfile

VALIDATE $? "Disabeling the mysql8 version"

cp /root/shellscript-roboshop/mysql.repo /etc/yum.repos.d/mysql.repo &>> $logfile

VALIDATE $? "Copying the MYSQL repo"

dnf install mysql-community-server -y &>> $logfile

VALIDATE $? "Installing the MYsql"

systemctl enable mysqld &>> $logfile

VALIDATE $? "enabeling the MYsql"

systemctl start mysqld &>> $logfile

VALIDATE $? "starting the MYsql"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $logfile

VALIDATE $? "We need to change the default root password in order to start using the database service"

mysql -uroot -pRoboShop@1 &>> $logfile

VALIDATE $? "mysql -uroot -pRoboShop@1"

