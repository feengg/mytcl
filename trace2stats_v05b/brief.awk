#extract the brief information from the simulation results
BEGIN {
	i = 1;
	flag = "throughput"
}

{
	if($1 == "avgDelay[ms]:" && flag == "delay")
		printf("%d %g\n", i++, $2)
	if($1 == "avgTput[kbps]:" && flag == "throughput")
		printf("%d %g\n", i++, $2)
	if($1 == "Total Tcp count:" && flag == "cnt")
		printf("%d %g\n", i++, $2)
	if($1 == "max" && $2 == "ACKed" && flag == "maxacked")
		printf("%d %g\n", i++, $4)
	if($1 == "ACKs" && $2 == "reveived:" && flag == "ackrecv")
		printf("%d %g\n", i++, $3)
	if($1 == "avgPathLength:" && flag == "pathLength")
		printf("%d %g\n", i++, $2)
	if($1 == "dropRate:" && flag == "dropRate")
		printf("%d %g\n", i++, $2)
    if($1 == "receivedPkts:" && flag == "receivedPkts")
        printf("%d %g\n", i++, $2)
    if($1 == "ACKs" && $2 == "sent:" && flag == "ACKs sent")
        printf("%d %g\n", i++, $3)
    if($1 == "ACKs" && $2 == "received:" && flag == "ACKs received")
        printf("%d %g\n", i++, $3)

}

END {
printf("\n");
}
