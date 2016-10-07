#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Node Length"
set ylabel "Throughput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
#set yrange [:200]

plot    './matcp/throughput' u 1:2 t 'Semi-TCP-RC' with linespoints, \
        './semitcp/throughput' u 1:2 t 'Semi-TCP' with linespoints
        #'./tcpap/throughput' u 1:2 t 'tcpap' with linespoints
        #'./newreno(d)/throughput' u 1:2 t 'newreno(d)' with linespoints, \
        #'./newreno(m)/throughput' u 1:2 t 'newreno(m)' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

