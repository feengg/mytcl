#!/bin/bash

# RECORD THE SIMLUATION TIME
date > q_length.txt
date > time.txt
date > HopsResultAvg.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=2

while [ $i -lt 16 ]; do
    echo >> q_length.txt
	echo --- Hop Node Number:$i --- >> q_length.txt
    echo --- Hop Node NUmber:$i --- >> time.txt
	../../../matcp/matcp chain.tcl 1 $i 100 7 0 1 1 >> q_length.txt 2>>time.txt
    let j=$i-1
	echo FINISH $j simulations, start to analyze...
	endnode=`expr $i - 1`

    gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt

    gawk -f ../../trace2stats_v05b/instantThroughputForTcp.awk tic=1 src=0 dst=$endnode flow=0 pkt=512 chain.tr > HopsResultInst.txt\(hops\=$i\)
    let i=i+1     
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

./drawAll.sh
./ackDraw.sh
./time.sh

cd ../
./throughput.sh
./delay.sh
