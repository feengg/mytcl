BEGIN {
	max_node_id = 0;
	
	pp=0;# the bit to control whether print the trace lines

	for(j=0; j<20; j++) {
		total[j]=0;
		mac[j]=0;
		rts_col[j]=0;
		rts_sent[j] = 0;
		mac_cbr_ret[j]=0;
		mac_tcp_ret[j]=0;
		mac_tcp_ncts[j]=0;
		mac_tcp_col[j]=0;
		mac_tcpack_ret[j]=0;
		mac_tcpack_col[j]=0;
		mac_congested[j]=0;
		mac_diy[j]=0;
		mac_rts_col[j] = 0;
		ifq[j]=0;
		route[j]=0;
		route_IFQ[j]=0;
	}
	ifq_arp = 0;
}

{
	# Trace line format: new
	if ($2 == "-t" && $1 == "s" && $19 == "MAC" && ($29 == "RTS" || $29 == "RTSC")) {
		rts_sent[$5]++		
	}
	if ($2 == "-t" && $1 == "d") {
		node_id = $5
		level = $19
		i_type = $35
		reason = $21
		if (node_id>max_node_id)
			max_node_id=node_id;
		if (level == "MAC"){
			mac[node_id]++;
			#if (reason == "Congested")
			#	mac_congested[node_id]++;
			#if (reason == "DIY")
			#	mac_diy[node_id]++;
			if (($29 == "RTS" || $29 == "RTSC") && reason == "COL")
				mac_rts_col[node_id]++
			#if (node_id == 0 && reason != "DIY")
			#	print $0;

			if ( (i_type =="tcp" || i_type =="pareto") && reason =="RET" ) {
				mac_tcp_ret[node_id]++;
			} else if ( (i_type =="tcp" || i_type =="pareto") && reason =="COL" ) {
				mac_tcp_col[node_id]++;
			} else if ( i_type =="ack" && reason =="RET" ) {
				mac_tcpack_ret[node_id]++;
			} else if ( i_type =="ack" && reason =="COL" ) {
				mac_tcpack_col[node_id]++;
			#} else if ( i_type =="cbr" && reason =="RET" ) {
			#	mac_cbr_ret[node_id]++;
			#} else if ( i_type =="tcp" && reason =="nCTS_BOUND" ) {
			#	mac_tcp_ncts[node_id]++;
			}
			
		} else if (level == "IFQ") {
			ifq[node_id]++;
			if(reason == "ARP")
				ifq_arp++;
			#print $0;
		} else if (level == "RTR"){
			route[node_id]++;
			if(reason == "IFQ")
				route_IFQ[node_id]++;
			
		} else 
			print $0;
	}
}

END {
	printf("%s\n", "                     Node ID");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", i);
	}
	print "\n";
	printf("%s\n", "                     RTS(C) sent");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", rts_sent[i]);
	}
	print "\n";
#	printf("%s\n", "                     MAC DROP");
#	for( i=0; i<=max_node_id; i++ ) {
#		printf("%8d", mac[i]);
#	}
	print "\n";
	printf("%s\n", "                     RTS COL");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", mac_rts_col[i]);
	}
	print "\n";
#	printf("%s\n", "                     MAC DROP DIY");
#	for( i=0; i<=max_node_id; i++ ) {
#		printf("%8d", mac_diy[i]);
#	}
#	print "\n";
	printf("%s\n", "                     IFQ DROP");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", ifq[i]);
	}
	print "\n";
	printf("%s\n", "                     ROUTE DROP");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", route[i]);
	}
	print "\n";
	printf("%s\n", "                     ROUTE DROP When route queue full");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", route_IFQ[i]);
	}
	print "\n";
	printf("%s\n", "                     TCP DROP AT MAC LAYER FOR RET");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", mac_tcp_ret[i]);
	}
#	print "\n";
#	printf("%s\n", "                     TCP DROP AT MAC LAYER FOR nCTS bound");
#	for( i=0; i<=max_node_id; i++ ) {
#		printf("%8d", mac_tcp_ncts[i]);
#	}
	print "\n";
	printf("%s\n", "                     TCP DROP AT MAC LAYER FOR COL");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", mac_tcp_col[i]);
	}
	print "\n";
	printf("%s\n", "                     TCP-ACK DROP BECAUSE OF RET");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", mac_tcpack_ret[i]);
	}
	print "\n";
	printf("%s\n", "                     TCP-ACK DROP BECAUSE OF COL");
	for( i=0; i<=max_node_id; i++ ) {
		printf("%8d", mac_tcpack_col[i]);
	}
	print "\n";
	printf(" DROP because of ARP failure %8d\n", ifq_arp);
#	printf("%s\n", "                     MAC DROP BECAUSE OF CONGESTION");
#	for( i=0; i<=max_node_id; i++ ) {
#		printf("%8d", mac_congested[i]);
#	}
#	print "\n";
#	printf("%s\n", "                     CBR DROP AT MAC LAYER FOR RET");
#	for( i=0; i<=max_node_id; i++ ) {
#		printf("%8d", mac_cbr_ret[i]);
#	}
#	print "\n";
}

