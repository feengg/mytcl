#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Node Length"
set ylabel "Delay / ms"
set key left top reverse
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
#set grid
set boxwidth 20

plot './orignal/delay' u 2:xtic(1) t 'orignal' with linespoints, \
	'./semitcp/delay' u 2 t 'semitcp' with linespoints, \
    './tcpap/delay' u 2 t 'tcpap' with linespoints, \
    './newreno/delay' u 2 t 'newreno' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

