BEGIN {
	max_node_id = 0;

	for(j=0; j<40; j++) {
		data_size[j] = 0
		total_size[j] = 0
		data_size_wnhead[j] = 0
		total_size_wnhead[j] = 0
		startTime[j] = 1e6
		stopTime[j] = 0
	}
}

{
	# Trace line format: new
	if ($2 == "-t" && $19 == "MAC") {
		node_id = $5
		level = $19
		i_type = $35
		mac_type = $29
		reason = $21
		i_size = $37
		event = $1
		time = $3
		if (node_id > max_node_id)
			max_node_id=node_id;
			
		if (event == "s" && (mac_type == "tcp" || mac_type == "ack" || mac_type == "udp")) {
			if (time < startTime[node_id])
				startTime[node_id] = time
			data_size[node_id] = i_size;
			data_size_wnhead[node_id] = i_size - 112;
		}

		if (event == "r" && mac_type == "ACK") {
			if (time > stopTime[node_id])
				stopTime[node_id] = time
			total_size[node_id] += data_size[node_id];
			total_size_wnhead[node_id] += data_size_wnhead[node_id];
		}
	}
}

END {
	printf("#node_id rate rate_without_head\n")
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d %g %g\n", i, (total_size[i]/(stopTime[i] - startTime[i]))*(8/1000), (total_size_wnhead[i]/(stopTime[i] - startTime[i]))*(8/1000));
	}
	print "\n";
}

