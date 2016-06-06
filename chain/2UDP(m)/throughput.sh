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
#set xrange [0:4]
set yrange [:600]

plot    './throughput_0' u 1:2 t 'UDP(m)(flow 0)' with linespoints, \
        './throughput_1' u 1:2 t 'UDP(m)(flow 1)' with linespoints, \
        './throughput' u 1:2 t 'UDP(m)(sum)' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

