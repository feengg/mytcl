#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "SendRate(Kbps)"
set ylabel "Packets"

#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'avg_length.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [80:350]
#set yrange [:180]

plot    './avg_length' u 1:2 t 'avg\_length' with linespoints lt 3 pt 1
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

