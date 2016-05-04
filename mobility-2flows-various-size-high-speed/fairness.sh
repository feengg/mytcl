#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Station Short Retry Limit"
set ylabel "Throghput(Kbps)"
set key right bottom
set term postscript eps monochrome blacktext "Helvetica" 24
set output 'fair.eps'
set autoscale
#set grid
set boxwidth 20

plot './ap/fairness' u 2:xtic(1) t 'TCP-AP' with linespoints, \
	'./semi/fairness' u 2 t 'Semi-TCP' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

