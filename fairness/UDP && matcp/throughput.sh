#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hop Length"
set ylabel "Throghput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
#set yrange [140:600]

plot    './TCP_throughput' u 1:2 t 'matcp' with linespoints, \
        './UDP_throughput' u 1:2 t 'UDP' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

