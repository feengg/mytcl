#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="avgSendTime:" q_length.txt > allAvgSendTime
gawk -f src_node_val.awk begin=50 step=10 allAvgSendTime > avgSendTime

rm allAvgSendTime
