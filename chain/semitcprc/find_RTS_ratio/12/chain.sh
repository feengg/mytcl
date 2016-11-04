#!/bin/bash

# RECORD THE SIMLUATION TIME
date > q_length.txt
date > HopsResultAvg.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=13
gap=0\.3
j=1
initial=10

while [ $initial -lt 40 ]; do
    echo >> q_length.txt
	echo --- Hop Node Number:$i --- >> q_length.txt
    min_RTS_DATA_ratio=$(echo "scale=2; $initial/10.0" | bc)
    max_RTS_DATA_ratio=$(echo "scale=2; $min_RTS_DATA_ratio+$gap" | bc)
	../../../../../semitcprc/semitcprc ../../chain.tcl 1 $i 300 7 1 1 1 $min_RTS_DATA_ratio $max_RTS_DATA_ratio >> q_length.txt
    echo min_RTS_DATA_ratio: $min_RTS_DATA_ratio, max_RTS_DATA_ratio: $max_RTS_DATA_ratio
	echo FINISH $j simulations, start to analyze...
	endnode=`expr $i - 1`

    gawk -f ../../../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt

    let j=j+1    
    let initial=initial+1
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput_tmp
gawk -f ../../../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay_tmp

gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio throughput_tmp > throughput
gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio delay_tmp > delay

rm throughput_tmp
rm delay_tmp

./throughput.sh
./delay.sh
