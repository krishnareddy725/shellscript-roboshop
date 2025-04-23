#!/bin/bash

ID=$(id -u)

Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
echo " Script execution time is $Timestamp "
logfile=/tmp/$0-$Timestamp

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE( ) {
    if [ $? -ne 0 ]; then

        echo -e " $2 ........$R is FAILED $N "
        exit -1

    else

        echo -e " $2 ..........$G is SUCCESS $N "

    fi
}

if [ $ID -ne 0 ]; then

    echo -e " $R You are NOT a root user..!$N "
    exit 1

else

    echo -e " $G you are a ROOT user. Please PROCCED...! $n"

fi

dnf module disable nodejs -y &>> $logfile

VALIDATE $? "Disabeling old nodejs"

dnf module enable nodejs:18 -y &>> $logfile

VALIDATE $? "Enabeling the new nodejs"

dnf install nodejs -y &>> $logfile

VALIDATE $? "Installing the nodejs"

id roboshop

if [ $? -ne 0 ]; then

    useradd roboshop &>> $logfile
    echo -e " $G roboshop user is CREATED $N"

else
    
    echo -e " $Y roboshop user ALREADY avilable in server $N" $logfile

fi

mkdir -p /app $logfile

VALIDATE $? "Creating the application directory"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip $logfile

VALIDATE $? "Downloading the user data"

cd /app $logfile

VALIDATE $? "moveing to the /app directory"

unzip /tmp/user.zip $logfile

VALIDATE $? "unzipping the user.zip file"

cd /app $logfile

VALIDATE $? "moveing to application directory"

npm install $logfile

VALIDATE $? "installing the dependencies for the app"

cp /root/shellscript-roboshop/user.service /etc/systemd/system/user.service $logfile

VALIDATE $? "copying the user.service file"

systemctl daemon-reload $logfile

VALIDATE $? "reloading the daemon"

systemctl enable user $logfile

VALIDATE $? "enabeling the user"

systemctl start user $logfile

VALIDATE $? "starting the user"

cp /root/shellscript-roboshop/mongo.repo /etc/yum.repos.d/mongo.repo $logfile

VALIDATE $? "copying the mongo.repo file"

dnf install mongodb-org-shell -y $logfile

VALIDATE $? "installing the mongodb repo"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js $logfile

VALIDATE $? "Loading the Schema"