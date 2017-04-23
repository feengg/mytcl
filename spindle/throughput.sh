#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Path length (hop)"
set ylabel "Throughput (kbps)"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 20
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
set yrange [50:300]

plot    './semitcprc/throughput' u 1:2 t 'Semi-TCP with algorithm 1' with linespoints lt 3 pt 4, \
        './semitcp/throughput' u 1:2 t 'Semi-TCP without algorithm 1' with linespoints lt 5 pt 6, \
        './tcpap/throughput' u 1:2 t 'TCP-AP' with linespoints lt 1 pt 2
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

