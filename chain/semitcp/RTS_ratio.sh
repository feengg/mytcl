#!/bin/bash

gawk -f ../../trace2stats_v05b/retrive.awk flag="RTS_per_forward_data:" q_length.txt > all_RTS_ratio
gawk -f RTS_ratio.awk all_RTS_ratio > RTS_ratio

./drawRTSRatio.sh
