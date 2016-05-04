#extract the brief information from the simulation results
BEGIN {
	seq = 1
	ii = 0
#	period=5
	for(jj = 0; jj < period; jj++)
		buf[jj] = 0;
}

{
		if(ii > 0 && ii % period == 0) {
			sum = 0;
			for(jj = 0; jj < period; jj++) {
				#if(buf[jj] == 0)
				#	printf("error!\n")
				#printf("%g ", buf[jj])
				sum += buf[jj]
				buff[jj] = 0
			}
			printf("%d %g\n", multiplier*(seq++), sum/period)
			#printf("\n")
		}
	
		buf[ii % period] = $2
		ii++
}

END {

}
