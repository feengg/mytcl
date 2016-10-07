#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Time(ms)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'sendTime.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
#set yrange [:10]

plot    './matcp/15-nodes/avgSendTime' u 1:2 t 'Semi-TCP-RC(avg)' with linespoints, \
        './semitcp/15-nodes/avgSendTime' u 1:2 t 'Semi-TCP(avg)' with linespoints, \
        './matcp/15-nodes/minSendTime' u 1:2 t 'Semi-TCP-RC(min)' with linespoints, \
        './semitcp/15-nodes/minSendTime' u 1:2 t 'Semi-TCP(min)' with linespoints

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

