#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Source rate (kbps)"
set ylabel "Throughput (kbps)"
set y2label "Attempts (packets)"

set title " "

set y2tics
set ytics nomirror

#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 20
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'figure_4_1.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [80:350]
set yrange [:180]
set y2range [1:4]

plot    './throughput' u 1:2 t 'End-to-end throughput' with linespoints axis x1y1 lt 3 pt 4, \
        './RTS_per_forward_data' u 1:2 t 'Average attempts per RTS' with linespoints axis x1y2 lt 5 pt 6
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

