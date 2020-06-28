#!/bin/bash

FILE_NAME=`date +%Y-%m-%d-%H_%M_%S`

systemctl stop minecraft

tar cf /var/minecraft/backup/${FILE_NAME}.tar /var/minecraft/server 

systemctl start minecraft
