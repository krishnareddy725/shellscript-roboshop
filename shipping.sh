#!/bin/bash

ID=$(id -u)
Timestamp=$(date +%Y-%m-%d-%H-%M-%S)
logfile=/tmp/$0-$Timestamp.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "Script execution Time is $Timestamp"

VALIDATE( ) {
    if [ $? -ne 0 ]; then

        echo -e " $2...........is $R FAILED..!"
        exit 1

    else

        echo -e " $2...........is $G SUCCESS..!"

    fi
}

if [ $id -ne 0 ]; then

    echo -e " $R you are NOT a ROOT user $N"
    exit 1

else

    echo -e " $G You are a ROOt user..Please procced $N "

fi

dnf install maven -y &>> $logfile

VALIDATE $? "Installing MAVENN"

id roboshop

if [ $? -ne 0 ]; then

    useradd roboshop
    echo -e "$G roboshop user creation has been completed $N " &>> $logfile

else

    echo -e " $G roboshop user already presented in server..! hence $Y SKIPPING...!$N" &>> $logfile

fi

mkdir -p /app &>> $logfile

VALIDATE $? "creating application direectory"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $logfile

VALIDATE $? "downloading the shipping software"

cd /app &>> $logfile

VALIDATE $? "moveing to application directory"

unzip /tmp/shipping.zip &>> $logfile

VALIDATE $? "unzipping the shipping"

cd /app &>> $logfile

VALIDATE $? "moveing to application directory"

mvn clean package &>> $logfile

VALIDATE $? "installing the maveen dependencies"

mv target/shipping-1.0.jar shipping.jar &>> $logfile

VALIDATE $? "untaring the zip files"

cp /root/shellscript-roboshop/shipping.service /etc/systemd/system/shipping.service &>> $logfile

VALIDATE $? "creating shipping service"

systemctl daemon-reload &>> $logfile

VALIDATE $? "reloading the daemon"

systemctl enable shipping &>> $logfile

VALIDATE $? "enabeling the shipping service"

systemctl start shipping &>> $logfile

VALIDATE $? "start the shipping service"

dnf install mysql -y &>> $logfile

VALIDATE $? "Install the mysql"

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> $logfile

VALIDATE $? "load schema"

systemctl restart shipping &>> $logfile

VALIDATE $? "restarting the shipping service"