#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Node Length"
set ylabel "Throghput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
#set grid
set boxwidth 20
set xrange [1:30]
set yrange [100:200]

plot    './matcp(m=1)/throughput' u 1:2 t 'matcp(m=1)' with linespoints, \
        './matcp(m=10)/throughput' u 1:2 t 'matcp(m=10)' with linespoints
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

