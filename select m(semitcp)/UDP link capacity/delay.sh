#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "m"
set ylabel "Delay / ms"
set key left top
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
#set grid
set boxwidth 20
#set yrange [0:1000]

plot    './delay(node=4)' u 1:2 t 'node=4' with linespoints, \
        './delay(node=5)' u 1:2 t 'node=5' with linespoints, \
        './delay(node=6)' u 1:2 t 'node=6' with linespoints, \
        './delay(node=7)' u 1:2 t 'node=7' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

