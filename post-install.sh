#!/bin/bash

###########user creatio^^n###^^^^^#####
useradd user;
passwd user pastepassword;
usermod -aG wheel user;
sudo sed -i 's/## Same thing without a password/&\nuser       ALL=(ALL)       NOPASSWD: ALL/' /etc/sudoers

#############configure permissions and keys for host

if [ -d /home/user/.ssh ]
then
        echo "Folder is created"
else
        mkdir -v /home/user/.ssh
        chmod 700 /home/user/.ssh
        chown user:user /home/user/.ssh


if [ -f /home/user/.ssh/authorized_keys ]
then
        echo "File exist and ansible can connect"

else
        echo "File is not configured"
        echo "pubkeyforansible ansible" > /home/user/.ssh/authorized_keys

        chmod 600 /home/user/.ssh/authorized_keys
        chown user:user /home/user/.ssh/authorized_keys
        chmod 700 /home/user/.ssh

fi


fi

###########edit of sshd_config to login remotely
sed -i 's+#HostKey /etc/ssh/ssh_host_rsa_key+HostKey /etc/ssh/ssh_host_rsa_key+g' /etc/ssh/sshd_config
sed -i 's+#HostKey /etc/ssh/ssh_host_ecdsa_key+HostKey /etc/ssh/ssh_host_ecdsa_key+g' /etc/ssh/sshd_config
sed -i 's+#HostKey /etc/ssh/ssh_host_ed25519_key+HostKey /etc/ssh/ssh_host_ed25519_key+g' /etc/ssh/sshd_config
sed -i 's/#StrictModes yes/StrictModes no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#UsePAM no/UsePAM yes/g' /etc/ssh/sshd_config

###############setting timezone

timedatectl set-timezone Europe/Amsterdam

##############selinux disabling

sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config


############activation of redhat/centos

release=$(cat /etc/redhat-release)

if [[ $release == "CentOS"* ]];
then
        echo "It's free version of Linux"
else
        echo "Please wait activation is progress"
        subscription-manager unregister;
        sleep 5;
        subscription-manager register --username "username" --password "password#" --auto-attach
fi
