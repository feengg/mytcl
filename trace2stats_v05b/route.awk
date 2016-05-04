BEGIN {
	aodv_col = 0;
}

{
	if ($2 == "-t") {
		event = $1
		time = $3
		node_id = $5
		flow_id = $39
		pkt_id = $41
		pkt_size = $37
		level = $19
		i_type = $35
		if(level == "MAC" && i_type == "AODV") {
			if(event == "d")
				aodv_col++;
		}
	}
}

END {
	printf(" %15s:  %d\n", "aodv collision", aodv_col)
}

