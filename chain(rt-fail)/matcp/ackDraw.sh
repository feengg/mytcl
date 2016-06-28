#!/bin/bash

gawk -f ../../trace2stats_v05b/brief.awk flag="receivedPkts" HopsResultAvg.txt > generatedACKs
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs sent" HopsResultAvg.txt > ACKsSent
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs received" HopsResultAvg.txt > ACKsReceived

./acks.sh
