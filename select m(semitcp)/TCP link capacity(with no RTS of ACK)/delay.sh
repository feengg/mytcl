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
#set yrange [0:200]

plot    './delay(node=22)' u 1:2 t 'node=22' with linespoints, \
        './delay(node=23)' u 1:2 t 'node=23' with linespoints, \
        './delay(node=24)' u 1:2 t 'node=24' with linespoints, \
        './delay(node=25)' u 1:2 t 'node=25' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

