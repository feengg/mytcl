#!/bin/bash

gawk -f ../trace2stats_v05b/retrive.awk flag="RTS_CTS_rate:" q_length.txt > all_RTS_CTS_rate
gawk -f src_node_val.awk begin=50 step=10 all_RTS_CTS_rate > RTS_CTS_rate

rm all_RTS_CTS_rate
