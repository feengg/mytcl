#!/bin/bash

gawk -f ../../trace2stats_v05b/retrive.awk flag="avgSendTime:" q_length.txt > allAvgSendTime
gawk -f avgSendTime.awk allAvgSendTime > avgSendTime

./drawAvgSendTime.sh

rm allAvgSendTime
