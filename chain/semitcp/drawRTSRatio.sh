#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hops length"
set ylabel "Packets"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'RTS_ratio.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
set yrange [1:5]

plot    './RTS_ratio' u 1:2 t 'RTS\_ratio' with linespoints
    
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

