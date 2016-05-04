#extract the brief information from the simulation results
BEGIN {
	period = 2
	for(jj = 0; jj < period; jj++)
		buf[jj] = 0;
	ii = 0 
}

{
	if(ii > 0 && ii % period == 0) {
		printf("%d ", ii / 2)
		#for(jj = 0; jj < period; jj++) {
		#	printf("%g ", buf[jj])
		#}
		printf("%g", (buf[0]+buf[1])^2/(2*(buf[0]^2 + buf[1]^2)) )
		printf("\n")
	}
	
	buf[ii % period] = $2
	ii++
}

END {
	printf("\n")
}
