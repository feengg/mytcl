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

plot    './delay(node=15)' u 1:2 t 'node=15' with linespoints, \
        './delay(node=16)' u 1:2 t 'node=16' with linespoints, \
        './delay(node=17)' u 1:2 t 'node=17' with linespoints, \
        './delay(node=18)' u 1:2 t 'node=18' with linespoints, \
        './delay(node=19)' u 1:2 t 'node=19' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

