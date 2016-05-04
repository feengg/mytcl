#!/bin/bash

# RECORD THE SIMLUATION TIME
#rm *.txt
date > HopsResultAvg.txt
date > overall.txt
date > q_length.txt
date > drop.txt
#date > interval.txt

# RUN FOUR SIMULATION WITH DIFFERENT TARFFIC FOR THE SAME MOBILTY SCENARIO
s=300
while [ $s -lt 1501 ]; do

	rs=0
	while [ $rs -lt 5 ]; do
	
		echo length: $s random seed: $rs >> q_length.txt
	   	../../bonnmotion-1.4/bin/bm -f RWP -I RWP.params RandomWaypoint -R $rs -l 45 -h 45 -y $s
		../../bonnmotion-1.4/bin/bm NSFile -f RWP > /dev/null
		../../semitcp chain.tcl 1 50 500 9 1 1 1 1 $s >> q_length.txt
		echo --- Random Seed :$rs length: $s ---  >> HopsResultAvg.txt
		echo --- Random Seed :$rs length: $s ---  >> overall.txt
		gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=49 flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
		gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=1 dst=48 flow=1 pkt=512 chain.tr >> HopsResultAvg.txt
		gawk -f ../../trace2stats_v05b/overallTcp.awk pkt=512 chain.tr >> overall.txt
		gawk -f ../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 

		let rs=rs+1
	done
		
	let s=s+300 
  
done

rm *.tr
rm *.nam

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" overall.txt > throughput_all
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" overall.txt > delay_all
gawk -f ../../trace2stats_v05b/brief.awk flag="dropRate" overall.txt > dropRate_all
gawk -f ../../trace2stats_v05b/brief.awk flag="pathLength" overall.txt > pathLength_all

gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=300 seq=1 throughput_all > throughput
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=300 seq=1 delay_all > delay
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=300 seq=1 dropRate_all > dropRate
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=300 seq=1 pathLength_all > pathLength

rm throughput_all delay_all dropRate_all pathLength_all

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > tmp
gawk -f ../../trace2stats_v05b/fairness.awk tmp > fairness_all
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=300 seq=1 fairness_all > fairness
rm tmp fairness_all




