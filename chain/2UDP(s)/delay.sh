#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hops length"
set ylabel "Delay(ms)"
set key left top
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
#set grid
set boxwidth 20
#set yrange [0:1000]

plot    './delay_0' u 1:2 t 'UDP(s)(flow 0)' with linespoints, \
        './delay_1' u 1:2 t 'UDP(s)(flow 1)' with linespoints, \
        './delay' u 1:2 t 'UDP(s)(sum)' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

