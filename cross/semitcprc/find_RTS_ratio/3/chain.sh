#!/bin/bash

# RECORD THE SIMLUATION TIME
date > overall.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
echo SIMULATION DURATION: 300.0S, AODV+TCP >> overall.txt

i=3
initial=10
gap=0\.3
count=1

while [ $initial -lt 40 ]; do
	j=`expr $i \* 2 + 1`
	echo --- Hop Node Number:$i --- >> q_length.txt
    min_RTS_DATA_ratio=$(echo "scale=2; $initial/10.0" | bc)
    max_RTS_DATA_ratio=$(echo "scale=2; $min_RTS_DATA_ratio+$gap" | bc)
	../../../../../semitcprc/semitcprc ../../chain.tcl 1 $j 300 7 1 0 1 1 $min_RTS_DATA_ratio $max_RTS_DATA_ratio >> q_length.txt
    echo min_RTS_DATA_ratio: $min_RTS_DATA_ratio, max_RTS_DATA_ratio: $max_RTS_DATA_ratio
	echo FINISH $count simulations, start to alalyze...
	echo >> overall.txt
	echo >> drop.txt
	echo --- Hop Node Number:$i ---	>> overall.txt

	gawk -f ../../../../trace2stats_v05b/overallTcp.awk pkt=512 chain.tr >> overall.txt
	let initial=initial+1     
    let count=count+1
done

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../../trace2stats_v05b/brief.awk flag="throughput" overall.txt > throughput_tmp
gawk -f ../../../../trace2stats_v05b/brief.awk flag="delay" overall.txt > delay_tmp

gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio.awk throughput_tmp > throughput
gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio.awk delay_tmp > delay

rm throughput_tmp
rm delay_tmp

./throughput.sh
./delay.sh