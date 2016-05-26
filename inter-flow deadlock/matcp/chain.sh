#!/bin/bash

#remove all of the unimportant files
#ls | grep -v '\.sh' | grep -v '\.tcl' | grep -v '\.eps' | xargs rm

date > HopsResultAvg_flow0.txt
date > HopsResultAvg_flow1.txt
#date > aodv_col.txt
date > q_length.txt
#date > drop.txt

    ../../../matcp/matcp chain.tcl 1 4 200 7 0 0 1 1 >> q_length.txt
	echo FINISH simulation, start to analyze...
	echo >> HopsResultAvg_flow0.txt
    echo >> HopsResultAvg_flow1.txt
#	echo >> aodv_col.txt
#	echo >> drop.txt
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=2 flow=0 pkt=512 chain.tr >> HopsResultAvg_flow0.txt
	gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=1 dst=3 flow=1 pkt=512 chain.tr >> HopsResultAvg_flow1.txt
#	gawk -f ../../trace2stats_v05b/route.awk chain.tr >> aodv_col.txt
#	gawk -f ../../trace2stats_v05b/drop.awk chain.tr >> drop.txt
	gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=2 flow=0 pkt=512 chain.tr > HopsResultInst_flow0.txt
	gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=1 dst=3 flow=1 pkt=512 chain.tr > HopsResultInst_flow1.txt

rm *.tr
#rm *.nam
#rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg_flow0.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg_flow1.txt >> throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg_flow0.txt > delay
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg_flow1.txt >> delay

./throught.sh
