#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d"." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

VALIDATE(){
 if [ $1 -ne 0]
 then 
     echo "$2...FAILURE"
     exit 1
 else
     echo "$2...SUCCESS"
 fi 
}


if [$USERID -ne 0 ]
then
    echo "Please run this script with root access." 
    exit 1 # manually exit if error comes.
else
    echo "you are super user."
fi 

dnf module disable nodejs -y &>>LOGFILE
VALIDATE $? "Disbaling default nodejs"

dnf module disable nodejs: 20 -y &>>LOGFILE
VALIDATE $? "Enabling nodejs:20 Version"

dnf install nodejs -y &>>LOGFILE
VALIDATE $? "Installing nodejs"

useradd expense
VALIDATE $?"Creating expense user"

