#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > udp.txt
#date > aodv_col.txt
#date > HopsResultInst.txt
date > q_length.txt
#date > drop.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+UDP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+UDP >> udp.txt
#echo SIMULATION DURATION: 300.0S, AODV+UDP >> aodv_col.txt
#echo SIMULATION DURATION: 300.0S, AODV+UDP >> HopsResultInst.txt
#echo SIMULATION DURATION: 300.0S, AODV+UDP >> drop.txt

while [ $i -lt 30 ]; do
    rate=1000
	echo --- Hop Node Number:$i --- >> q_length.txt
    ../../../ns-2.29/ns chain.tcl 3 $i 100 7 $rate"Kb" >> q_length.txt
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
	echo >> HopsResultAvg.txt
    echo >> udp.txt
	#echo >> aodv_col.txt
	#echo >> drop.txt
	#echo >> HopsResultInst.txt
	echo --- Hop Node Number:$i ---	>> HopsResultAvg.txt
    #echo --- UDP Rate: $rate"Kbps" --- >> HopsResultAvg.txt
	#echo --- Hop Node Number:$i ---	>> aodv_col.txt
	#echo --- Hop Node Number:$i ---	>> HopsResultInst.txt
    #echo --- UDP Rate: $rate"Kbps" --- >> HopsResultInst.txt
	#echo --- Hop Node Number:$i ---	>> drop.txt
	endnode=`expr $i - 1`
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=1 pkt=512 chain.tr >> HopsResultAvg.txt
    gawk -f ../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
	#gawk -f ../../trace2stats_v05b/route.awk chain.tr >> aodv_col.txt
	#gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
	#gawk -f ../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 
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
