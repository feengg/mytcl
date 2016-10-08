#!/bin/bash

# RECORD THE SIMLUATION TIME
date > q_length.txt
date > HopsResultAvg.txt

# RUN FOUR SIMULATION WITH DIFFERENT CONGETIONTHRESHOLD UNDER THE SAME PATHLENGTH
i=15

echo >> q_length.txt
echo --- Hop Node Number:$i --- >> q_length.txt
../../../../matcp/matcp ../chain.tcl 1 $i 300 7 1 1 1 >> q_length.txt
let j=$i-1
echo FINISH $j simulations, start to analyze...
endnode=`expr $i - 1`

gawk -f ../../../trace2stats_v05b/avgStatsForTcp.awk src=0 dst=$endnode flow=0 pkt=512 chain.tr >> HopsResultAvg.txt

gawk -f ../../../trace2stats_v05b/instantThroughputForTcp.awk tic=0\.1 src=0 dst=$endnode flow=0 pkt=512 chain.tr > HopsResultInst.txt

rm *.tr
rm *.nam
rm tmp

gawk -f ../../../trace2stats_v05b/brief.awk flag="throughput" HopsResultAvg.txt > throughput
gawk -f ../../../trace2stats_v05b/brief.awk flag="delay" HopsResultAvg.txt > delay

gawk -f ../../../trace2stats_v05b/brief.awk flag="receivedPkts" HopsResultAvg.txt > generatedACKs
gawk -f ../../../trace2stats_v05b/brief.awk flag="ACKs sent" HopsResultAvg.txt > ACKsSent

gawk -f ../../../trace2stats_v05b/brief.awk flag="RTS(C)_send" q_length.txt > RTS\(C\)_send
gawk -f ../../../trace2stats_v05b/brief.awk flag="RetransmitRTS" q_length.txt > RetransmitRTS
gawk -f ../../../trace2stats_v05b/brief.awk flag="RetransmitDATA" q_length.txt > RetransmitDATA
gawk -f ../../../trace2stats_v05b/brief.awk flag="RTS droped" q_length.txt > RTS_droped
gawk -f ../../../trace2stats_v05b/brief.awk flag="RTS_CTS_rate" q_length.txt > RTS_CTS_rate
gawk -f ../../../trace2stats_v05b/brief.awk flag="all_success_rate" q_length.txt > all_success_rate
gawk -f ../../../trace2stats_v05b/brief.awk flag="avgSendTime" q_length.txt > avgSendTime
gawk -f ../../../trace2stats_v05b/brief.awk flag="minSendTime" q_length.txt > minSendTime
gawk -f ../../../trace2stats_v05b/brief.awk flag="avg_length" q_length.txt > avg_length
gawk -f ../../../trace2stats_v05b/brief.awk flag="send_time_vec" q_length.txt > send_time_vec_tmp

gawk -f ./send_time_vec.awk send_time_vec_tmp > send_time_vec
rm send_time_vec_tmp

./RTS\(C\)_send.sh
./RetransmitRTS.sh
./RetransmitDATA.sh
./RTS_droped.sh
./RTS_CTS_rate.sh
./all_success_rate.sh
./sendTime.sh
./avg_length.sh
./send_time_vec.sh
./send_time_vec_and_inst.sh

./InstThroughput.sh
