#!/bin/sh
#set -e
#exec usermod -l $JPY_USER jovyan
#exec su $JPY_USER

set -e
useradd $JPY_USER -d /home/jovyan
echo $JPY_USER:jupyter | chpasswd
userdel jovyan
su $JPY_USER