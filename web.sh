#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e " $G Script started executing at $Timestamp %N"

VALIDATE( ) {

    if [ $? -ne 0 ]; then

        echo -e "$2.........is $R FAILED..!$N"
        exit 1

    else

        echo -e "$2...........is $G SUCEESS..! $N"
    fi
}

if [ $ID -ne 0 ]; then

    echo -e " $R you are NOT a root user $N "
    exit 1

else

    echo -e "$G You are ROOT user..! Please PROCEED $N"

fi

dnf install nginx -y &>> $logfile

VALIDATE $? "Installing the nginx"

systemctl enable nginx &>> $logfile

VALIDATE $? "enabeling the nginx"

systemctl start nginx &>> $logfile

VALIDATE $? "starting the nginx"

rm -rf /usr/share/nginx/html/* &>> $logfile

VALIDATE $? "removeing the default html pages"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $logfile

VALIDATE $? "Downloading the web page"

cd /usr/share/nginx/html &>> $logfile

VALIDATE $? "moveing to html page"

unzip /tmp/web.zip &>> $logfile

VALIDATE $? "unzipping the web page"

cp /root/shellscript-roboshop/roboshop.conf /etc/nginx/default.d/roboshop.conf &>> $logfile

VALIDATE $? "copying the roboshop service file"

systemctl restart nginx &>> $logfile

VALIDATE $? "restarting the NGINX service"


