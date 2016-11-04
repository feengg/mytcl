#!/bin/bash

# RECORD THE SIMLUATION TIME
date > q_length.txt
date > HopsResultAvg.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
init_rate=50
step=10
max_rate=250

nodes=15
j=1
rate=$init_rate

while [ $rate -lt $max_rate ]; do
    echo >> q_length.txt
	echo --- sending rate: $rate kbps --- >> q_length.txt
	../../notcp/notcp chain.tcl 1 $nodes 300 7 1 1 1 $rate >> q_length.txt
    echo FINISH $j simulations, send rate: $rate kbps...
	endnode=`expr $nodes - 1`

    gawk -f ../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt

    let rate=rate+step    
    let j=j+1
done

rm *.tr
rm *.nam
rm tmp

gawk -f ./brief.awk flag="throughput" begin=$init_rate step=$step HopsResultAvg.txt > throughput

hop=`expr $nodes - 1`

./avgSendTime.sh $init_rate $step $hop
./RTS_per_forward_data.sh $init_rate $step $hop

./figure_4.sh
