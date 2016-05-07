#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hop Length"
set ylabel "Delay / ms"
set key left top reverse
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:28]
#set yrange [0:1000]

plot './semitcp/delay' u 1:2 t 'semitcp' with linespoints, \
    './matcp/delay' u 1:2 t 'matcp' with linespoints, \
    './newreno/delay' u 1:2 t 'newreno' with linespoints, \
    './tcpap/delay' u 1:2 t 'tcpap' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

