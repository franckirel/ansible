#!/bin/bash

if [ -f /root/ansible/profile ]; then
   # restauration des fichiers sauvegardes
   mv /root/ansible/lbn-system.sh /etc/profile.d/
   mkdir -p /usr/local/linkbynet/script/system/etc/
   rm -rf /usr/local/linkbynet/script/system/etc/profile.d 
   mv /root/ansible/* /usr/local/linkbynet/script/system/etc/
   rm -rf /root/ansible
   # suppression des fichiers nobackup et des repertoires /home/lbn/
   rm -rf /home/nobackup/*
   rm -rf /root/lwsclient
   mv /home/lbn/{batch,lbn-admin,default,f.moube} /home/nobackup/
   rm -rf /home/lbn/*
   mv /home/nobackup/* /home/lbn/
   find /root/ -mindepth 1 -type d -exec rm -rf {} \; 
   find /root/ -mindepth 1 -type f ! -name ".bash*" ! -name "authorized_keys" ! -name "known_hosts" ! -name ".profile"  -delete
   # suppression des utilisateurs lbn
   for output in $(/bin/grep  '/home/lbn/' /etc/passwd  |  /bin/cut -f1 -d':' | /bin/egrep -Z -v '(batch|lbn-admin|default|f.moube)');do userdel $output; done
   find /usr/local/linkbynet/ -type f -name '*.rpmnew' -o -name '*.rpmsave' -delete
else
  #Fichiers a garder apres deinstallations des packets
  mkdir -p /root/ansible
  cp -rp /usr/local/linkbynet/script/system/etc/profile* /root/ansible/
  cp -rp /usr/local/linkbynet/script/system/etc/proxy* /root/ansible/
  cp -rp /usr/local/linkbynet/script/system/etc/prompt /root/ansible/
  cp -rp /etc/profile.d/lbn-system.sh /root/ansible/
fi
