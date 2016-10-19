#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Time(s)"
set ylabel "Time(ms)"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'inst_send_time.eps'
set autoscale
set grid
set boxwidth 20
set xrange [10:20]
set yrange [:30]

plot    './send_time_vec' u 1:2 t 'inst\_send\_time' with linespoints 
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

