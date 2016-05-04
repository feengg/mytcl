#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hop Length"
set ylabel "Delay / ms"
set key left top
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
#set grid
set boxwidth 20
#set yrange [0:1000]

plot        './TCP_delay(m=1)' u 1:2 t 'TCP:m=1' with linespoints, \
    './UDP_delay(m=1)' u 1:2 t 'UDP:m=1' with linespoints, \
    './TCP_delay(m=5)' u 1:2 t 'TCP:m=5' with linespoints, \
    './UDP_delay(m=5)' u 1:2 t 'UDP:m=5' with linespoints, \
    './TCP_delay(m=13)' u 1:2 t 'TCP:m=13' with linespoints, \
    './UDP_delay(m=13)' u 1:2 t 'UDP:m=13' with linespoints, \
    './TCP_delay(m=25)' u 1:2 t 'TCP:m=25' with linespoints, \
    './UDP_delay(m=25)' u 1:2 t 'UDP:m=25' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

