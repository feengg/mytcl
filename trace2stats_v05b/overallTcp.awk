BEGIN {
	startTime = 1e6
	stopTime = 0

	sentNum = 0;	#the total number of TCP diagrams including the retransmitted
	retxNum = 0;	#the number of TCP diagrams retransmitted

	recvdSize = 0;	#the total size of TCP diagrams, not counting the duplicated ones.
	ackSentNum = 0;	#the number of ACK sent by the destination
	ackRecvdNum = 0;	#the number of ACK received at the source
	maxAckedSeqno = -1;	#the biggest acked seqno

	maxSeqnoSent = -1;	#the max seqno sent at the source
	
	tcpDroppedNum = 0
	tcpDroppedRETNum = 0
	
	recvUnique = 0
	
	avgPathLength = 0
	pathLengthSample = 0
	
	drop_count = 0
	total_sent = 0
	rt_req = 0
}

{
	# Trace line format: new
	if ($2 == "-t") {
		event = $1
		time = $3
		node_id = $5
		flow_id = $39
		pkt_id = $41
		pkt_size = $37
		level = $19
		i_type = $35
		reason = $21
		if (event == "d" && reason != "END" && (i_type == "ack" || i_type =="tcp") && (level == "RTR" || level == "IFQ"))
			drop_count++;
		if (event == "s" && level == "AGT")
			total_sent++
			
		if (event == "s" && level == "RTR" && $43 >= 30)
			rt_req++

		if (level == "AGT" && event == "r")
			avgPathLength = (avgPathLength * pathLengthSample + 31 - $43) / (++ pathLengthSample)

		if (level == "AGT" && i_type == "tcp" && pkt_size >= pkt) {
			seqno = $47
			if (event == "s") {
				if (time < startTime) {
					startTime = time
				}
				sendTime[pkt_id] = time
				sentNum++
			}
			# Update total received packets' size and store packets arrival time
			if (event == "r" && recvTime[pkt_id] == 0) {
				if (time > stopTime) {
					stopTime = time
				}
				if (fresh[seqno, flow_id] == 0) { #the newcomming packet
					fresh[seqno, flow_id] = 1;
					# Rip off the header
					hdr_size = pkt_size % pkt
					pkt_size -= hdr_size
					# Store received packet's size
					recvdSize += pkt_size
					# Store packet's reception time
					recvTime[pkt_id] = time
					#DEBUG
					#if(recvTime[pkt_id] - sendTime[pkt_id] > 1.600)
					#	print $0
					#End DEBUG
					recvUnique++
				}
			}
		}
        if (level == "AGT" && i_type == "ack") {
            seqno = $47
            if (event == "r"){
                ackRecvdNum++;
                if (seqno > maxAckedSeqno)
                    maxAckedSeqno = seqno
            }
            if (event == "s"){
                ackSentNum++;    
            }
        }
	}
}

END {
	# Compute average delay
	delay = avg_delay = recvdNum = numForDelay = 0
	for (i in recvTime) {
		if (sendTime[i] == 0) {
			printf("\nError in delay.awk: receiving a packet that wasn't sent %g\n",i)
		}
		tmp = recvTime[i] - sendTime[i]
		if(tmp > 0.0) {
			delay += tmp;
			numForDelay++;
		}
		recvdNum ++
	}
	if (numForDelay != 0) {
		avg_delay = delay / numForDelay
	} else {
		avg_delay = 0
	}
	# Output
	if (recvdNum == 0) {
		printf("####################################################################\n" \
		       "#  Warning: no packets were received, simulation may be too short  #\n" \
		       "####################################################################\n\n")
	}
	printf("\n")
	printf(" %15s:  %d\n", "startTime", startTime)
	printf(" %15s:  %d\n", "stopTime", stopTime)
	printf(" %15s:  %d\n", "sentPkts", sentNum)
	
	printf(" %15s:  %g\n", "rt_request_cnt", rt_req)
	printf(" %15s:  %g\n", "receivedPkts", recvdNum)
	printf(" %15s:  %g\n", "receivedUniquePkts", recvUnique)
	printf(" %15s:  %g\n", "avgTput[kbps]", (recvdSize/(stopTime-startTime))*(8/1000))
	printf(" %15s:  %g\n", "avgDelay[ms]", avg_delay*1000)
    printf(" %15s:  %g\n", "max ACKed Seqno", maxAckedSeqno)
    printf(" %15s:  %g\n", "ACKs sent", ackSentNum)
    printf(" %15s:  %g\n", "ACKs received", ackRecvdNum)
	printf(" %15s:  %g\n", "avgPathLength", avgPathLength)
	printf(" %15s:  %g\n", "dropCount", drop_count)
	printf(" %15s:  %g\n", "totalSent", total_sent)
	printf(" %15s:  %g\n", "dropRate", drop_count / total_sent)
}

