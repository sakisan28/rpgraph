#!/bin/bash
#cat /proc/stat /proc/net/dev /proc/diskstats /proc/meminfo
#free
#vmstat -d
#netstat -i

cd `dirname $0` || exit 1
. rpgraph.conf

DATAFILEHEADER="utime cpu user sys idle lo lo_rx lo_tx eth0 eth0_rx eth0_tx wlan0 wlan0_rx wlan0_tx mem total free buffers cached swap total used / total used /boot total used mmcblk0 read write sda read write temp C clock MHz"

UTIME=`date +%s`

CLOCK=`awk '{print "clock",$0 / 1000}' /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`
#echo $CLOCK

TEMP=`awk '{printf "temp %2.2f\n",$0 / 1000}' /sys/class/thermal/thermal_zone0/temp`
#echo $TEMP

#obtain from /proc/stat
#name, user, nice, system,
CPU=`awk '{print $1,$2+$3,$4,$5;exit}' /proc/stat`
#echo $CPU

#name,user,system,idle
#CPU=`vmstat 1 2| awk '{if(NR==4) print "cpu",$13,$14,$15}'`
#echo $CPU

#name, receive(total packets), transmit
#IF_eth0=`awk '/eth0/{print "eth0",$2,$10}' /proc/net/dev`
#echo $IF_eth0
#IF_wlan0=`awk '/wlan0/{print "wlan0",$2,$10}' /proc/net/dev`
#echo $IF_wlan0
#IF_lo=`awk '/lo/{print "lo",$2,$10}' /proc/net/dev`
#echo $IF_lo

#name, receive(total packets), transmit
IF_eth0=`netstat -i|awk '/eth0/{print "eth0",$4,$8}'`
#echo $IF_eth0
IF_wlan0=`netstat -i|awk '/wlan0/{print "wlan0",$4,$8}'`
#echo $IF_wlan0
IF_lo=`netstat -i|awk '/lo/{print "lo",$4,$8}'`
#echo $IF_lo

#name,total,free,buffers,cached
MEM=`free | awk '/Mem:/{print "mem",$2,$4,$6,$7}'`
#echo $MEM

#name,total,used
SWAP=`free | awk '/Swap:/{print "swap",$2,$3}'`
#echo $SWAP

#name,total,used
DFROOT=`df | awk '/root/{print "/",$2,$3}'`
#echo $DFROOT

DFBOOT=`df | awk '/boot/{print "/boot",$2,$3}'`
#echo $DFBOOT

#name,read(total),write
MMCBLK0=`vmstat -d|awk '/mmcblk0/{print $1,$2,$6}'`
#echo $MMCBLK0
SDA=`vmstat -d|awk '/sda/{print $1,$2,$6}'`
#echo $SDA

if [ ! -e $DATAFILERAW ]; then
    echo $DATAFILEHEADER > $DATAFILERAW ;
    echo $UTIME $CPU $IF_lo $IF_eth0 $IF_wlan0 $MEM $SWAP $DFROOT $DFBOOT $MMCBLK0 $SDA $TEMP $CLOCK >> $DATAFILERAW ;
fi

echo $UTIME $CPU $IF_lo $IF_eth0 $IF_wlan0 $MEM $SWAP $DFROOT $DFBOOT $MMCBLK0 $SDA $TEMP $CLOCK >> $DATAFILERAW


tail -n 2 $DATAFILERAW | awk '
{
    if(old[1]>0){
        printf("%s ",$1);
        for(i=2;i<=NF;i++){
            printf("%d ",$i-old[i]);
        }
        printf("\n");
    }
    for(i=1;i<=NF;i++){
        old[i]=$i;
    }
}' >> $DATAFILEDIFF
