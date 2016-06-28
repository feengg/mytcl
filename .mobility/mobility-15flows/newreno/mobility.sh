#!/bin/bash

# RECORD THE SIMLUATION TIME
date > overall.txt
date > q_length.txt
date > drop.txt

# RUN FOUR SIMULATION WITH DIFFERENT TARFFIC FOR THE SAME MOBILTY SCENARIO
v=1
while [ $v -lt 10 ]; do

	velocity=`expr $v \* 5`
	../../bonnmotion-1.4/bin/bm -f RWP -I RWP.params RandomWaypoint -R 0 -l $velocity -h $velocity
	../../bonnmotion-1.4/bin/bm NSFile -f RWP > /dev/null
	rs=0
	while [ $rs -lt 5 ]; do
	
		echo velocity: $velocity random seed: $rs >> q_length.txt
		#../../bonnmotion-1.4/bin/bm -f RWP -I RWP.params RandomWaypoint -R $rs -l $velocity -h $velocity
		../../semitcp ~/ns-allinone-2.29/ns-2.29/indep-utils/cmu-scen-gen/cbrgen.tcl -type semitcp -nn 50 -seed $rs -mc 15 > semitcptraffic
		../../semitcp chain.tcl 1 50 1000 7 1 1 1 1 >> q_length.txt
		echo --- Random Seed :$rs velocity: $velocity ---  >> overall.txt
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
gawk -f ../../trace2stats_v05b/tp-avg.awk period=5 multiplier=5 throughput_all > throughput
gawk -f ../../trace2stats_v05b/tp-avg.awk period=5 multiplier=5 delay_all > delay
