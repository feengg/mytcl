#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Time(ms)"
set y2label "Packets"

set y2tics
set ytics nomirror

set title " "

#set key right bottom
set key right top right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 16
set output 'figure_3.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
#set yrange [0:]
#set y2range　[0:]

plot    './avgSendTime' u 1:2 t 'avg\_send\_time' with linespoints axis x1y1 lt 3 pt 4, \
        './avg_length' u 1:2 t 'avg\_length' with linespoints axis x1y2 lt 5 pt 6
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

