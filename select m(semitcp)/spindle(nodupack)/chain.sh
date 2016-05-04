#!/bin/bash

# RECORD THE SIMLUATION TIME
date > HopsResultAvg.txt
date > overall.txt
date > macRate
#date > aodv_col.txt
#date > HopsResultInst.txt
date > q_length.txt
date > drop.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=1
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultAvg.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> overall.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> aodv_col.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> HopsResultInst.txt
echo SIMULATION DURATION: 300.0S, AODV+TCP >> drop.txt

while [ $i -lt 21 ]; do
	echo --- Hop Node Number:$i --- >> q_length.txt
	../../../semitcp/semitcp chain.tcl 0 $i 100 9 1 1 1 0 1 >> q_length.txt
	echo FINISH $i simulations, start to alalyze...
	echo >> HopsResultAvg.txt
	echo >> overall.txt
#	echo >> aodv_col.txt
	echo >> drop.txt
#	echo >> HopsResultInst.txt
	echo --- Hop Node Number:$i ---	>> HopsResultAvg.txt
	echo --- Hop Node Number:$i ---	>> overall.txt
	echo --- Simulation sequence:$i ---	>> macRate
#	echo --- Hop Node Number:$i ---	>> aodv_col.txt
#	echo --- Hop Node Number:$i ---	>> HopsResultInst.txt
	echo --- Hop Node Number:$i ---	>> drop.txt
	endnode1=`expr $i + 3`
	endnode2=`expr $i + 2`
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode2 flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=1 dst=$endnode1 flow=1 pkt=512 chain.tr >> HopsResultAvg.txt
	gawk -f ../../trace2stats_v05b/overallTcp.awk pkt=512 chain.tr >> overall.txt
	gawk -f ../../trace2stats_v05b/mac_rate.awk chain.tr >> macRate
#	gawk -f ../../trace2stats_v05b/route.awk chain.tr >> aodv_col.txt
	gawk -f ../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 
	let i=i+1     
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
#gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay
gawk -f ../../trace2stats_v05b/fairness.awk throughput > fairness
rm throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" overall.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" overall.txt > delay
gawk -f ../../trace2stats_v05b/brief.awk flag="dropRate" overall.txt > dropRate
