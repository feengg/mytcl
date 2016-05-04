#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
#date > HopsResultInst.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=1
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
#echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt

while [ $i -lt 30 ]; do
    node=19
	echo --- m: $i --- >> q_length.txt
    ../../../semitcp/semitcp chain.tcl 0 $node 100 7 0 1 1 $i 1 >> q_length.txt
	echo FINISH simulation $i, start to analyze...
	echo >> HopsResultAvg.txt
	#echo >> HopsResultInst.txt
	echo --- m: $i ---	>> HopsResultAvg.txt
	#echo --- m: $i ---	>> HopsResultInst.txt
    let endnode=$node-1
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	#gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
    let i=i+1    
    echo
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

