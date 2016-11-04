#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "min\\_RTS\\_DATA\\_ratio"
set ylabel "Throughput(Kbps)"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
#set xrange [1:14]
#set yrange [50:350]

plot    './5/throughput' u 1:2 t '' with linespoints lt 4 pt 5, \
    './10/throughput' u 1:2 t '' with linespoints lt 5 pt 6, \
    './15/throughput' u 1:2 t '' with linespoints lt 1 pt 2, \
     './20/throughput' u 1:2 t '' with linespoints lt 3 pt 4, \
     './25/throughput' u 1:2 t '' with linespoints lt 7 pt 8, \
     './30/throughput' u 1:2 t '' with linespoints lt 9 pt 10, \
     './35/throughput' u 1:2 t '' with linespoints lt 11 pt 12, \
     './40/throughput' u 1:2 t '' with linespoints lt 2 pt 1, \
     './45/throughput' u 1:2 t '' with linespoints lt 4 pt 3
    
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

