#!/bin/bash

# RECORD THE SIMLUATION TIME
date > q_length.txt
date > HopsResultAvg.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=15

echo >> q_length.txt
echo --- Hop Node Number:$i --- >> q_length.txt
../../../../semitcp/semitcp ../chain.tcl 0 $i 300 7 1 0 1 1 1 >> q_length.txt
let j=$i-1
echo FINISH $j simulations, start to analyze...
endnode=`expr $i - 1`

gawk -f ../../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt

gawk -f ../../../trace2stats_v05b/instantThroughputForTcp.awk tic=0\.2 src=0 dst=$endnode flow=0 pkt=512 chain.tr > HopsResultInst.txt

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

gawk -f ../../../trace2stats_v05b/retrive.awk flag="RTS_retransmit_rate:" q_length.txt > RTS_retransmit_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="RTS_drop_rate:" q_length.txt > RTS_drop_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="forward_data_retransmit_rate:" q_length.txt > forward_data_retransmit_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="forward_data_drop_rate:" q_length.txt > forward_data_drop_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="RTS_CTS_rate:" q_length.txt > RTS_CTS_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="all_success_rate:" q_length.txt > all_success_rate
gawk -f ../../../trace2stats_v05b/retrive.awk flag="avgSendTime:" q_length.txt > avgSendTime
gawk -f ../../../trace2stats_v05b/retrive.awk flag="avg_length:" q_length.txt > avg_length
gawk -f ../../../trace2stats_v05b/retrive.awk flag="RTS_per_forward_data:" q_length.txt > RTS_per_forward_data

gawk -f ../../../trace2stats_v05b/brief.awk flag="send_time_vec" q_length.txt > send_time_vec_tmp

gawk -f send_time_vec.awk send_time_vec_tmp > send_time_vec
rm send_time_vec_tmp

./RTS_retransmit_rate.sh
./RTS_drop_rate.sh
./forward_data_retransmit_rate.sh
./forward_data_drop_rate.sh
./RTS_CTS_rate.sh
./all_success_rate.sh
./sendTime.sh
./avg_length.sh
./send_time_vec.sh
./RTS_per_forward_data.sh

./send_time_vec_and_inst.sh

./InstThroughput.sh
