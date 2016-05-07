#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > aodv_col.txt
date > HopsResultInst.txt
date > q_length.txt
date > drop.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=1
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> aodv_col.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> drop.txt

while [ $i -lt 11 ]; do
	echo --- Hop Node Number:$idletime"ms" --- >> q_length.txt
	idletime=`expr $i \* 100`
	../../../semitcp chain.tcl 1 $idletime"ms" 100 7 0 1 1 1 >> q_length.txt
	echo FINISH $idletime"ms" simulations, start to alalyze...
	echo >> HopsResultAvg.txt
	echo >> aodv_col.txt
	echo >> drop.txt
	echo >> HopsResultInst.txt
	echo --- Hop Node Number:$idletime"ms" ---	>> HopsResultAvg.txt
	echo --- Hop Node Number:$idletime"ms" ---	>> aodv_col.txt
	echo --- Hop Node Number:$idletime"ms" ---	>> HopsResultInst.txt
	echo --- Hop Node Number:$idletime"ms" ---	>> drop.txt
	endnode=9
	gawk -f ../../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../../trace2stats_v05b/route.awk chain.tr >> aodv_col.txt
	gawk -f ../../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultInst.txt
	gawk -f ../../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 
    let i=i+1     
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

