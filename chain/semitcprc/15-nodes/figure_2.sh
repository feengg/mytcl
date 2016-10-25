#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "# of node"
set ylabel "Percent"
#set y2label "Percent"

#set y2tics
#set ytics nomirror

set title " "

#set key right bottom
set key right top right
set term postscript eps monochrome blacktext "Helvetica" 16
#set term postscript eps enhanced color blacktext "Helvetica" 16
set output 'figure_2.eps'
set autoscale
set grid
set boxwidth 20
set xrange [1:14]
set yrange [0:]
#set y2range　[0:]

plot    './RTS_drop_rate' u 1:2 t 'RTS\_drop\_rate' with linespoints lt 3, \
    './forward_data_drop_rate' u 1:2 t 'forward\_data\_drop\_rate' with linespoints lt 5
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

