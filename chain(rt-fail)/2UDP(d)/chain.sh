#!/bin/bash

q_length=q_length.txt

# RECORD THE SIMLUATION TIME
date > udp.txt
date > udp0.txt
date > udp1.txt
date > $q_length

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+UDP >> udp.txt

while [ $i -lt 21 ]; do
    rate=1000
	echo --- Hop Node Number:$i --- >> $q_length
    ../../../tcpap/tcpap chain.tcl 3 $i 100 7 1 $rate"Kb" >> $q_length
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
    echo >> udp.txt
	endnode=`expr $i - 1`

    gawk -f ../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
    gawk -f ../../trace2stats_v05b/avgStatsForMultiUDP.awk flow=0 chain.tr >> udp0.txt
    gawk -f ../../trace2stats_v05b/avgStatsForMultiUDP.awk flow=1 chain.tr >> udp1.txt
    gawk -f ../../trace2stats_v05b/instantThroughputForUdp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr > HopsResultInst.txt_0\(hops\=$i\)
    gawk -f ../../trace2stats_v05b/instantThroughputForUdp.awk tic=1 src=$endnode dst=0 flow=1 pkt=512 chain.tr > HopsResultInst.txt_1\(hops\=$i\)
    let i=i+1    
    echo
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp.txt > delay

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp0.txt > throughput_0
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp0.txt > delay_0

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp1.txt > throughput_1
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp1.txt > delay_1

./throughput.sh
./delay.sh

./drawAll.sh
