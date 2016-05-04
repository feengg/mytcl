BEGIN {
	startTime = 1e6
	stopTime = 0
	recvdSize = 0;	#the total size of TCP diagrams, not counting the duplicated ones.
}

{
	# Trace line format: new
	if ($2 == "-t") {
		event = $1
		time = $3
		pkt_id = $41
		pkt_size = $37
		level = $19
		i_type = $35
		if (level == "AGT" && i_type == "cbr") {
			if (event == "s") {
				if (time < startTime) {
					startTime = time
				}
				sendTime[pkt_id] = time
				#print $0
			}
			# Update total received packets' size and store packets arrival time
			if (event == "r") {
				if (time > stopTime) {
					stopTime = time
				}
				# Store received packet's size
				recvdSize += pkt_size
				# Store packet's reception time
				recvTime[pkt_id] = time
			}
		}
	}
}

END {
	# Compute average delay
	delay = avg_delay = numForDelay = 0
	for (i in recvTime) {
		if (sendTime[i] == 0) {
			printf("\nError in delay.awk: receiving a packet that wasn't sent %g\n",i)
		}
		tmp = recvTime[i] - sendTime[i]
		if(tmp > 0.0) {
			#printf("Ii:%d tmp:%f\n", i, tmp)
			delay += tmp;
			numForDelay++;
		}
	}
	if (numForDelay != 0) {
		avg_delay = delay / numForDelay
	} else {
		avg_delay = 0
	}
	# Output
	printf(" %15s:  %d\n", "startTime", startTime)
	printf(" %15s:  %d\n", "stopTime", stopTime)
	printf(" %15s:  %g\n", "avgTput[kbps]", (recvdSize/(stopTime-startTime))*(8/1000))
	printf(" %15s:  %g\n", "avgDelay[ms]", avg_delay*1000)

}

