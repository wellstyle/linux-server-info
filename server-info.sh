#!/bin/bash

function printInfo { printf "%-23s: %s\n" "$1" "$2"; }

IFS=$'\n'
IP_ADDR=`/usr/sbin/ifconfig -a | grep inet | head -1 | awk '{print $2}'`
HOST=`uname -n`
OS=`cat /etc/*release | grep PRETTY_NAME | awk -F'"' '{print $2}'`
KERNEL=`uname -sr`
CPU=`cat /proc/cpuinfo | grep "model name" | head -1 | awk -F':' '{print $2}' | cut -c2-`
CPU_NUM=`cat /proc/cpuinfo | grep -c processor`
CPU_MHZ=`cat /proc/cpuinfo | grep "cpu MHz" | head -1 | awk -F':' '{print $2}' | cut -c2-`
M_TYPE=`uname -m`
MEM_SIZE=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
MEM_SIZE_KB=`cat /proc/meminfo | grep MemTotal | awk '{print $3}'`
HDD_SIZE=`lsblk --nodeps --noheadings --output NAME,SIZE`
LOCALE=`echo $LANG`

printInfo "Hostname" "$HOST"
printInfo "IP Address" "$IP_ADDR"
printInfo "OS Version" "$OS"
printInfo "Kernel Version" "$KERNEL"
printInfo "CPU " "$CPU"
printInfo "CPU Number" "$CPU_NUM"
printInfo "CPU MHz" "$CPU_MHZ"
printInfo "Machine Type" "$M_TYPE"
if [ "$MEM_SIZE_KB" = "kB" ]
then
  MEM_SIZE=`echo "scale=2; $MEM_SIZE/1000000" | bc`
  MEM_SIZE_KB="G"
fi
printInfo "Memory Size" "$MEM_SIZE$MEM_SIZE_KB"
for hdd in $HDD_SIZE; do
        printInfo "HDD Size" "$hdd"
done
printInfo "Locale" "$LOCALE"
