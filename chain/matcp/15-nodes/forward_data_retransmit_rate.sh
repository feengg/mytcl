#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Percent"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'forward_data_retransmit_rate.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:15]
set yrange [:2]

plot    './forward_data_retransmit_rate' u 1:2 t 'forward\_data\_retransmit\_rate' with linespoints lt 7 pt 8 
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

