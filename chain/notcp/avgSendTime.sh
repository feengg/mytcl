#!/bin/bash

gawk -f allAvgSendTime.awk q_length.txt > allAvgSendTime
gawk -f avgSendTime.awk allAvgSendTime > avgSendTime

./drawAvgSendTime.sh
