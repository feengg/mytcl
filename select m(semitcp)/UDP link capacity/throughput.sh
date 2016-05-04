#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "m"
set ylabel "Throghput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [1:30]
#set yrange [160:300]

plot    './throughput(node=4)' u 1:2 t 'node=4' with linespoints, \
        './throughput(node=5)' u 1:2 t 'node=5' with linespoints, \
        './throughput(node=6)' u 1:2 t 'node=6' with linespoints, \
        './throughput(node=7)' u 1:2 t 'node=7' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

