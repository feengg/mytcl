#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "SendRate(Kbps)"
set ylabel "Throughput(Kbps)"
set y2label "Rate"

set title " "

set y2tics
set ytics nomirror

#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'figure_4.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [80:350]
set yrange [:200]
set y2range [:5]

plot    './throughput' u 1:2 t 'throughput' with linespoints axis x1y1 lt 3 pt 1, \
        './rate_to_min_send_time' u 1:2 t 'avgSendTime/minSendTime' with linespoints axis x1y2 lt 5 pt 2, \
        './RTS_per_forward_data' u 1:2 t 'RTS/DATA' with linespoints axis x1y2 lt 2 pt 4
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

