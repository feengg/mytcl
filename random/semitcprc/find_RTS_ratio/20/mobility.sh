#!/bin/bash

# RECORD THE SIMLUATION TIME
date > overall.txt
date > q_length.txt

# RUN FOUR SIMULATION WITH DIFFERENT TARFFIC FOR THE SAME MOBILTY SCENARIO
velocity=20

initial=10
gap=0\.3
count=1

while [ $initial -lt 40 ]; do
	rs=0
    min_RTS_DATA_ratio=$(echo "scale=2; $initial/10.0" | bc)
    max_RTS_DATA_ratio=$(echo "scale=2; $min_RTS_DATA_ratio+$gap" | bc)
	while [ $rs -lt 5 ]; do
		echo velocity: $velocity random seed: $rs >> q_length.txt
	   	../../../../bonnmotion-1.4/bin/bm -f RWP -I RWP.params RandomWaypoint -R $rs -l $velocity -h $velocity
		../../../../bonnmotion-1.4/bin/bm NSFile -f RWP > /dev/null
		../../../../../semitcprc/semitcprc ../../chain.tcl 1 52 300 7 1 0 1 1 $min_RTS_DATA_ratio $max_RTS_DATA_ratio >> q_length.txt
        echo min_RTS_DATA_ratio: $min_RTS_DATA_ratio, max_RTS_DATA_ratio: $max_RTS_DATA_ratio
		echo --- Random Seed :$rs velocity: $velocity ---  >> overall.txt
        echo FINISH $count simulations, start to analysize...
		gawk -f ../../../../trace2stats_v05b/overallTcp.awk pkt=512 chain.tr >> overall.txt
		let rs=rs+1
    done
    let initial=initial+1
    let count=count+1
done

rm *.tr
rm *.nam

gawk -f ../../../../trace2stats_v05b/brief.awk flag="throughput" overall.txt > throughput_all
gawk -f ../../../../trace2stats_v05b/brief.awk flag="delay" overall.txt > delay_all
gawk -f ../../../../trace2stats_v05b/avg.awk period=5 multiplier=1 throughput_all > throughput_tmp
gawk -f ../../../../trace2stats_v05b/avg.awk period=5 multiplier=1 delay_all > delay_tmp

gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio.awk throughput_tmp > throughput
gawk -f ../../../../trace2stats_v05b/seq_to_min_RTS_ratio.awk delay_tmp > delay

rm throughput_tmp throughput_all delay_tmp delay_all

./throughput.sh
./delay.sh
