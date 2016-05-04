#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hop Length"
set ylabel "Delay / ms"
set key left top reverse
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
#set grid
set boxwidth 20
#set yrange [0:1500]

plot    './delay(m=1)' u 1:2 t 'm=1' with linespoints, \
    './delay(m=2)' u 1:2 t 'm=2' with linespoints, \
    './delay(m=3)' u 1:2 t 'm=3' with linespoints, \
    './delay(m=5)' u 1:2 t 'm=5' with linespoints, \
    './delay(m=8)' u 1:2 t 'm=8' with linespoints, \
    './delay(m=13)' u 1:2 t 'm=13' with linespoints, \
    './delay(m=21)' u 1:2 t 'm=21' with linespoints, \
    './delay(m=34)' u 1:2 t 'm=34' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

