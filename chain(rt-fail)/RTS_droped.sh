#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "# of Packets"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'RTS_droped.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
#set yrange [:200]

plot    './matcp/15-nodes/RTS_droped' u 1:2 t 'Semi-TCP-RC' with linespoints, \
        './semitcp/15-nodes/RTS_droped' u 1:2 t 'Semi-TCP' with linespoints
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

