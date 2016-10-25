#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Percent"
#set key right bottom
set key left top reverse
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'CTSC_rate.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
#set yrange [3000:12000]

plot    './CTSC_rate' u 1:2 t 'CTSC\_rate' with linespoints lt 5 pt 6
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

