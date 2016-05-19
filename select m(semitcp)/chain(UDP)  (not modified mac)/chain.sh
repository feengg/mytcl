#!/bin/bash

throughput=throughput
delay=delay
q_length=q_length.txt

# RECORD THE SIMLUATION TIME
date > udp.txt
date > $q_length

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+UDP >> udp.txt

while [ $i -lt 30 ]; do
    rate=2000
	echo --- Hop Node Number:$i --- >> $q_length
    ../../../tcpap/tcpap chain.tcl 3 $i 100 7 $rate"Kb" >> $q_length
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
    echo >> udp.txt
	endnode=`expr $i - 1`
    gawk -f ../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
    let i=i+1    
    echo
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp.txt > $throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp.txt > $delay

./throughput.sh
./delay.sh
