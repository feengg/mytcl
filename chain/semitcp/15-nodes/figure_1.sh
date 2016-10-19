#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Packets"
set y2label "Percent"

set y2tics
set ytics nomirror

set title " "

#set key right bottom
set key right top right
set term postscript eps monochrome blacktext "Helvetica" 16
#set term postscript eps enhanced color blacktext "Helvetica" 16
set output 'figure_1.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
#set yrange [10:40]
#set y2range　[100:400]

plot    './RTS_per_forward_data' u 1:2 t 'RTS\_per\_forward\_data' with linespoints axis x1y1 lt 3, \
    './forward_data_retransmit_rate' u 1:2 t 'forward\_data\_retransmit\_rate' with linespoints axis x1y2 lt 5
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

