#!/bin/bash

gawk -f ../../trace2stats_v05b/brief.awk flag="receivedPkts" overall.txt > generatedACKs
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs sent" overall.txt > ACKsSent
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs received" overall.txt > ACKsReceived

./acks.sh
