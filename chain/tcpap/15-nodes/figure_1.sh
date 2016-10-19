#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Packets"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'figure_1.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
set yrange [:550]

plot    './retransmit_forward_data' u 1:2 t 'DATA\_retransmit' with linespoints lt 7 pt 8, \
    './RTS_droped' u 1:2 t 'RTS\_drop' with linespoints lt 5 pt 6
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

