#!/bin/bash
###########polskagurom

##bad one
#ifconfig | egrep -i "inet " | cut -c 14- | cut -d " " -f 1

##good pattern
#ifconfig | egrep -i "broadcast " | cut -c 14- | cut -d " " -f 7


for broadcast in `ifconfig | egrep -i "broadcast " | cut -c 14- | cut -d " " -f 7`
do
#       echo $broadcast
        if [ $broadcast == "gateway of NIC1" ] || [ $broadcast == "gateway of NIC2" ]
        then
                echo "ISN zone"
                for chrony in `chronyc sources | cut -c 4- | cut -d " " -f1`
                do
                        if [ $chrony == "your destination NTP server" ] || [ $chrony == "your destination NTP server 2" ]
                        then
                                echo "Chrony it's configured properly"
                                exit 100
                        else
                                for line in `cat /etc/chrony.conf | grep -n pool | cut -d ":" -f 1`
                                do
                                         sudo sed -i "${line}s|^|#|g" /etc/chrony.conf
                                         sudo sh -c 'echo "server ntp" >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server ntp" >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server " >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server " >> /etc/chrony.conf'

                                         sudo systemctl restart chronyd.service
                                         chronyc sources | grep esa
                                         exit 100
                                 done
                        fi
                done

        elif [ $broadcast == "gateway of NIC1" ] || [ $broadcast == "gateway of NIC2" ] || [ $broadcast == "gateway of NIC3" ]
        then
                echo "DMZ zone"
                for chrony in `chronyc sources | cut -c 4- | cut -d " " -f1`
                do
                        if [ $chrony == "your destination NTP server" ] || [ $chrony == "your destination NTP server2" ]
                        then
                                echo "Chrony it's configured properly"
                                exit 100
                        else
                                for line in `cat /etc/chrony.conf | grep -n pool | cut -d ":" -f 1`
                                do
                                         sudo sed -i "${line}s|^|#|g" /etc/chrony.conf
                                         sudo sh -c 'echo "server  iburst" >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server  iburst" >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server  iburst" >> /etc/chrony.conf'
                                         sudo sh -c 'echo "server  iburst" >> /etc/chrony.conf'

                                         sudo systemctl restart chronyd.service
                                         chronyc sources | grep esa
                                         exit 100
                                 done
                        fi
                done

        else
                echo "No GW or not setup"

        fi
done

