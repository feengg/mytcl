#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="avg_length:" q_length.txt > all_avg_length
gawk -f src_node_val.awk begin=50 step=10 all_avg_length > avg_length

rm all_avg_length
