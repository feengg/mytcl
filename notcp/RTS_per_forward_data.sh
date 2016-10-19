#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="RTS_per_forward_data:" q_length.txt > all_RTS_per_forward_data
gawk -f src_node_val.awk begin=50 step=10 all_RTS_per_forward_data > RTS_per_forward_data

rm all_RTS_per_forward_data
