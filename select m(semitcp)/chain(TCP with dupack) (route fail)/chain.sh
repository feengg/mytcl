#!/bin/bash

m=$1

q_length=q_length.txt\(\m=$m\)
throughput=throughput\(\m=$m\)
delay=delay\(\m=$m\)

rm $q_length
rm $throughput
rm $delay

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > HopsResultInst.txt
date > $q_length

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt

while [ $i -lt 30 ]; do
	echo --- Hop Node Number:$i --- >> $q_length
    ../../../semitcp/semitcp chain.tcl 0 $i 100 7 0 0 1 $m 1 >> $q_length
    let j=$i-1
	echo FINISH simulation $j, start to analyze...
	echo >> HopsResultAvg.txt
	echo >> HopsResultInst.txt
	echo --- Hop Node Number:$i ---	>> HopsResultAvg.txt
	echo --- Hop Node Number:$i ---	>> HopsResultInst.txt
	endnode=`expr $i - 1`
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
    let i=i+1    
    echo
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > $throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > $delay

./throughput.sh
./delay.sh

