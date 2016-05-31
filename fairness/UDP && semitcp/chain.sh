#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > udp.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+UDP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+UDP >> udp.txt

while [ $i -lt 21 ]; do
    rate=1000
	echo --- Hop Node Number:$i --- >> q_length.txt
    ../../../semitcp/semitcp chain.tcl 0 $i 100 7 0 0 1 5 1 $rate"Kb" >> q_length.txt
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
	echo >> HopsResultAvg.txt
    echo >> udp.txt
	echo --- Hop Node Number:$i ---	>> HopsResultAvg.txt
	endnode=`expr $i - 1`
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=1 pkt=512 chain.tr >> HopsResultAvg.txt
    gawk -f ../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
    let i=i+1    
    echo
done

rm *.tr
#rm *.nam
#rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > TCP_throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > TCP_delay
gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp.txt > UDP_throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp.txt > UDP_delay
