#!/bin/bash

gawk -f ../../trace2stats_v05b/brief.awk flag="receivedPkts" overall.txt > generatedACKs_all
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs sent" overall.txt > ACKsSent_all
gawk -f ../../trace2stats_v05b/brief.awk flag="ACKs received" overall.txt > ACKsReceived_all

gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 generatedACKs_all > generatedACKs
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 ACKsSent_all > ACKsSent
gawk -f ../../trace2stats_v05b/avg.awk period=5 multiplier=5 ACKsReceived_all > ACKsReceived

./acks.sh
