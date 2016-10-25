#!/bin/bash

gawk -f ./rate_to_min_send_time.awk avgSendTime > rate_to_min_send_time

./draw_rate_to_min_send_time.sh
