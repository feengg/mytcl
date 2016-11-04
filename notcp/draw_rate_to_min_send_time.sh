#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "SendRate(Kbps)"
set ylabel "rate"

#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'rate_to_min_send_time.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [80:350]
#set yrange [:3]

plot    './rate_to_min_send_time' u 1:2 t 'rate\_to\_min\_send\_time' with linespoints lt 3 pt 1
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

