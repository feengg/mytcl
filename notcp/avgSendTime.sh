#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="avgSendTime:" q_length.txt > allAvgSendTime
gawk -f src_node_val.awk begin=$1 step=$2 hop=$3 allAvgSendTime > avgSendTime
gawk -f ./rate_to_min_send_time.awk avgSendTime > rate_to_min_send_time

./draw_rate_to_min_send_time.sh

rm allAvgSendTime
rm avgSendTime
