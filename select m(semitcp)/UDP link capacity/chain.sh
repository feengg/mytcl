#!/bin/bash

# RECORD THE SIMLUATION TIME
date > udp.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=1
echo SIMULATION DURATION: 300.0S, AODV+UDP >> udp.txt

while [ $i -lt 30 ]; do
    rate=1000
    node=30
	echo --- m: $i --- >> q_length.txt
    ../../../semitcp/semitcp chain.tcl 0 $node 100 7 0 1 1 $i 1 $rate"Kb" >> q_length.txt
	echo FINISH simulation $i, start to analyze...
    echo >> udp.txt
    gawk -f ../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
    let i=i+1    
    echo
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" udp.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" udp.txt > delay
