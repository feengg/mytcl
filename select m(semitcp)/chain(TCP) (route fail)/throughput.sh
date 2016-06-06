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
#set yrange [130:340]

plot    './throughput(m=1)' u 1:2 t 'm=1' with linespoints, \
        './throughput(m=2)' u 1:2 t 'm=2' with linespoints, \
        './throughput(m=3)' u 1:2 t 'm=3' with linespoints, \
        './throughput(m=5)' u 1:2 t 'm=5' with linespoints, \
        './throughput(m=8)' u 1:2 t 'm=8' with linespoints, \
        './throughput(m=13)' u 1:2 t 'm=13' with linespoints, \
        './throughput(m=21)' u 1:2 t 'm=21' with linespoints, \
        './throughput(m=34)' u 1:2 t 'm=34' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

