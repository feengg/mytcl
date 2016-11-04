#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="RTS_per_forward_data:" q_length.txt > all_RTS_per_forward_data
gawk -f src_node_val.awk begin=$1 step=$2 hop=$3 all_RTS_per_forward_data > RTS_per_forward_data

./draw_RTS_per_forward_data.sh

rm all_RTS_per_forward_data
