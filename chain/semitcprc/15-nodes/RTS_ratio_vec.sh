#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Time(s)"
set ylabel "Packets"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'inst_RTS_ratio.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [20:30]
#set yrange [:30]

plot    './RTS_ratio_vec' u 1:2 t 'inst\_RTS\_ratio' with linespoints 
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

