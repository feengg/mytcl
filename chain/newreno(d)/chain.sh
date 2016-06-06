#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > HopsResultInst.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt

while [ $i -lt 21 ]; do
    echo >> q_length.txt
	echo --- Hop Node Number:$i --- >> q_length.txt
	../../../tcpap/tcpap chain.tcl 3 $i 300 7 0 >> q_length.txt
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
	echo >> HopsResultAvg.txt
	echo >> HopsResultInst.txt
	echo --- Hop Node Number:$i ---	>> HopsResultAvg.txt
	echo --- Hop Node Number:$i ---	>> HopsResultInst.txt
	endnode=`expr $i - 1`
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
    let i=i+1     
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

