#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Hops length"
set ylabel "Time(ms)"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'RTS_ratio.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
set yrange [0:5]

plot    './semitcprc/RTS_ratio' u 1:2 t 'Semi-TCP-RC' with linespoints lt 3 pt 4, \
        './semitcp/RTS_ratio' u 1:2 t 'Semi-TCP' with linespoints lt 5 pt 6, \
        './semitcprc/find_RTS_ratio/best_min_RTS_ratio' u 1:2 t 'best\_min\_RTS\_ratio' with linespoints lt 1 pt 2

set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot
