#!/bin/bash

# go to root
cd


# update
yum -y update

#install Desktop
yum -y groupinstall Desktop

yum -y install gnome-core xfce4 firefox

#install vnc server
yum -y install tigervnc-server

#install dependency
yum -y install xorg-x11-fonts-Type1

#start vnc server on boot
chkconfig vncserver on

#create default username & password
PASS=qwe123;
useradd sadarvnc
#echo "sadarvnc:$PASS" | vncpasswd

#!/usr/bin/expect --
spawn vncpasswd
expect "Password: "
send "$PASS\r"
expect "Verify: "
send "$PASS\r"
expect "$"



echo 'VNCSERVERS="1:sadarvnc"' >> /etc/sysconfig/vncservers
echo 'VNCSERVERARGS[1]="-geometry 800x600"' >> /etc/sysconfig/vncservers

sudo iptables -I INPUT 5 -m state --state NEW -m tcp -p tcp -m multiport --dports 5901:5903,6001:6003 -j ACCEPT
sudo service iptables save
sudo service iptables restart


service vncserver restart

pkill vnc


sed -i 's/twm/#twm/g' /home/sadarvnc/.vnc/xstartup
echo 'exec gnome-session &' >> /home/sadarvnc/.vnc/xstartup

# info
clear
echo "Mazpaijo -- sadarssh.tk"
echo "==============================================="
echo ""
echo "VNC Server berhasil di instal. untuk menggunakan silahkan download di"
echo "http://www.realvnc.com/download/viewer/"
echo ""
echo ""
echo "SILAHKAN REBOOT VPS ANDA !"
echo ""
echo "==============================================="
