BEGIN {
    # flow src dst pkt are set on the shell script
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
	
	rtsNum = 0
	
	receivedUnique = 0;
	
	num_acked = 0;
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
		if (level == "AGT" && flow_id == flow && (i_type == "tcp" || i_type == "pareto") && pkt_size >= pkt) {
			if($54 == "-NumAcked")
				num_acked = $55
			seqno = $47
			if (node_id == src && event == "s") {
				if (time < startTime) {
					startTime = time
				}
				sendTime[pkt_id] = time
				sentNum++
				# Count the retransmited packet
				if(seqno > maxSeqnoSent)
					maxSeqnoSent = seqno;
				else
					retxNum++;
			}
			# Update total received packets' size and store packets arrival time
			if (node_id == dst && event == "r" && recvTime[pkt_id] == 0) {
				if (time > stopTime) {
					stopTime = time
				}
				if (fresh[seqno, flow] == 0) { #the newcomming packet
					receivedUnique++;
					fresh[seqno, flow] = 1;
					# Rip off the header
					hdr_size = pkt_size % pkt
					pkt_size -= hdr_size
					# Store received packet's size
					recvdSize += pkt_size
					# Store packet's reception time
					recvTime[pkt_id] = time
				}
			}
		}
		
		if (level == "MAC" && event == "s" && ($29 == "RTS" || $29 == "RTSC")) {
			rtsNum++
		}

		# Count the tcp packets dropped
		#if (level == "MAC" && i_type == "tcp" && event == "d") {
		#	tcpDroppedNum++;
		#	reason = $21
		#	if(printout)
		#		print $0
		#	if(reason == "RET")
		#		tcpDroppedRETNum++
		#}
		
		# Count the number of ACKs received
		if (level == "AGT" && i_type == "ack") {
			seqno = $47
			if(event == "r" && node_id == src ) {
				ackRecvdNum++;
				if(seqno > maxAckedSeqno)
					maxAckedSeqno = seqno
			}
			if(event == "s" && node_id == dst ) {
				ackSentNum++;
			}
		}
	}
}

END {
	maxAckedSeqno = maxAckedSeqno > num_acked ? maxAckedSeqno : num_acked;
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
	printf(" %15s:  %g\n", "flowID", flow)
	printf(" %15s:  %d\n", "srcNode", src)
	printf(" %15s:  %d\n", "destNode", dst)
	printf(" %15s:  %d\n", "startTime", startTime)
	printf(" %15s:  %d\n", "stopTime", stopTime)
	printf(" %15s:  %d\n", "sentPkts", sentNum)
	printf(" %15s:  %d\n", "max seqno sent", maxSeqnoSent)
	printf(" %15s:  %d\n", "Tcp retxed", retxNum)
	
	printf(" %15s:  %g\n", "receivedPkts", recvdNum)
	printf(" %15s:  %g\n", "receivedUnique", receivedUnique)
	printf(" %15s:  %g\n", "avgTput[kbps]", (recvdSize/(stopTime-startTime))*(8/1000))
	printf(" %15s:  %g\n", "avgDelay[ms]", avg_delay*1000)

	printf(" %15s:  %d\n", "max ACKed Seqno", maxAckedSeqno)
	
	printf(" %15s:  %d\n", "ACKs sent", ackSentNum)
	printf(" %15s:  %d\n", "ACKs received", ackRecvdNum)
	printf(" %15s:  %d\n", "RTS(C) Sent", rtsNum)
	
#	printf(" %15s:  %d\n", "Tcp dropped RET", tcpDroppedRETNum)
#	printf(" %15s:  %d\n", "Tcp dropped", tcpDroppedNum)
}

