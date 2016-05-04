BEGIN {
	control_pkt_cnt = 0;
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
		if (level == "MAC" && event == "s" && ($29 == "ARP" || $29 == "AODV")) {
			control_pkt_cnt++
			#print $0
		}
	}

}

END {
	printf("Control pkts: %d\n",control_pkt_cnt)
}

