#!/bin/bash

if [ -z "$(getent passwd $JPY_USER)" ]; then
   olduser=jovyan
   newuser=$JPY_USER

   olduser_GROUPS=$(id -Gn ${olduser} | sed "s/${olduser} //g" | sed "s/ ${olduser}//g" | sed "s/ /,/g")
   olduser_SHELL=$(awk -F : -v name=${olduser} '(name == $1) { print $7 }' /etc/passwd)

   useradd --groups $olduser_GROUPS --shell $olduser_SHELL $newuser

   mkdir /home/$newuser
   chown -R $newuser:$newuser /home/$newuser

   #rsync -aPv /home/$olduser/. /home/$newuser/
   chown -R --from=$olduser $newuser:$newuser /home/$newuser

   grep -rlI $olduser /home/$newuser/ . | sudo xargs sed -i 's/$olduser/$newuser/g'
fi
su $JPY_USER
