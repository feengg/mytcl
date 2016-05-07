#!/bin/bash

# RECORD THE SIMLUATION TIME
#rm *.txt
date > HopsResultAvg.txt
date > overall.txt
date > q_length.txt
date > drop.txt
#date > interval.txt

# RUN FOUR SIMULATION WITH DIFFERENT TARFFIC FOR THE SAME MOBILTY SCENARIO
v=1
while [ $v -lt 10 ]; do

	velocity=`expr $v \* 5`
	rs=0
	while [ $rs -lt 5 ]; do
	
		echo velocity: $velocity random seed: $rs >> q_length.txt
	   	../../bonnmotion-1.4/bin/bm -f RWP -I RWP.params RandomWaypoint -R $rs -l $velocity -h $velocity
		../../bonnmotion-1.4/bin/bm NSFile -f RWP > /dev/null
		../../semitcp chain.tcl 1 50 500 9 1 1 1 1 >> q_length.txt
		echo --- Random Seed :$rs velocity: $velocity ---  >> HopsResultAvg.txt
		echo --- Random Seed :$rs velocity: $velocity ---  >> overall.txt
		gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=49 flow=0 pkt=512 chain.tr >> HopsResultAvg.txt
		gawk -f ../../trace2stats_v05b/avgStatsForTcp.awk src=1 dst=48 flow=1 pkt=512 chain.tr >> HopsResultAvg.txt
		gawk -f ../../trace2stats_v05b/overallTcp.awk pkt=512 chain.tr >> overall.txt
		gawk -f ../../trace2stats_v05b/drop.awk chain.tr >> drop.txt 

		let rs=rs+1
	done
		
	let v=v+1 
  
done

rm *.tr
rm *.nam

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" overall.txt > throughput_all
gawk -f ../../trace2stats_v05b/brief.awk flag="delay" overall.txt > delay_all
gawk -f ../../trace2stats_v05b/brief.awk flag="dropRate" overall.txt > dropRate_all
gawk -f ../../trace2stats_v05b/brief.awk flag="pathLength" overall.txt > pathLength_all

gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 throughput_all > throughput
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 delay_all > delay
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 dropRate_all > dropRate
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 pathLength_all > pathLength

rm throughput_all delay_all dropRate_all pathLength_all

gawk -f ../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > tmp
gawk -f ../../trace2stats_v05b/fairness.awk tmp > fairness_all
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 fairness_all > fairness
rm tmp fairness_all




