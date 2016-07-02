#!/bin/bash

gawk -f ../../trace2stats_v05b/time.awk flag="avgSendTime" time.txt > avgSendTime
gawk -f ../../trace2stats_v05b/time.awk flag="maxSendTime" time.txt > maxSendTime
gawk -f ../../trace2stats_v05b/time.awk flag="minSendTime" time.txt > minSendTime

./drawTime.sh
