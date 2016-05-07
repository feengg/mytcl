#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > udp.txt
date > aodv_col.txt
date > HopsResultInst.txt
date > q_length.txt
date > drop.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=1
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> udp.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> aodv_col.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> drop.txt

while [ $i -lt 8 ]; do
	rate=`expr $i \* 8`
	echo --- UDP Rate: $rate"Kb" --- >> q_length.txt
	../../../semitcp chain.tcl 1 10 100 $rate"Kb" 0 1 1 1 >> q_length.txt
	echo FINISH $i simulations, start to analyze...
	echo >> HopsResultAvg.txt
	echo >> udp.txt
	echo >> aodv_col.txt
	echo >> drop.txt
	echo >> HopsResultInst.txt
	echo --- UDP Rate: $rate"Kb" ---	>> HopsResultAvg.txt
	echo --- UDP Rate: $rate"Kb" ---	>> udp.txt
	echo --- UDP Rate: $rate"Kb" ---	>> aodv_col.txt
	echo --- UDP Rate: $rate"Kb" ---	>> HopsResultInst.txt
	echo --- UDP Rate: $rate"Kb" ---	>> drop.txt
	endnode=9
	gawk -f ../../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../../trace2stats_v05b/avgStatsForUDP.awk chain.tr >> udp.txt
	gawk -f ../../../trace2stats_v05b/route.awk chain.tr >> aodv_col.txt
	gawk -f ../../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
	gawk -f ../../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 
    let i=i+1     
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../trace2stats_v05b/brief.awk flag="throughput" i=0 HopsResultAvg.txt > throughput
gawk -f ../../../trace2stats_v05b/brief.awk flag="delay" i=0 HopsResultAvg.txt > delay

