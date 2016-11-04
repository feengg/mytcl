#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "min\\_RTS\\_DATA\\_ratio"
set ylabel "Time(ms)"
#set key right bottom
set key right top Right
set term postscript eps monochrome blacktext "Helvetica" 24
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'

set grid
set boxwidth 20
#set xrange [1:14]
#set yrange [50:350]

plot    './1/delay' u 1:2 t '' with linespoints lt 2 pt 3, \
    './2/delay' u 1:2 t '' with linespoints lt 5 pt 6, \
    './3/delay' u 1:2 t '' with linespoints lt 1 pt 2, \
     './4/delay' u 1:2 t '' with linespoints lt 3 pt 4, \
     './5/delay' u 1:2 t '' with linespoints lt 7 pt 8, \
     './6/delay' u 1:2 t '' with linespoints lt 9 pt 10, \
     './7/delay' u 1:2 t '' with linespoints lt 11 pt 12, \
     './8/delay' u 1:2 t '' with linespoints lt 2 pt 1, \
     './9/delay' u 1:2 t '' with linespoints lt 4 pt 3, \
     './10/delay' u 1:2 t '' with linespoints lt 6 pt 5, \
     './11/delay' u 1:2 t '' with linespoints lt 8 pt 7, \
     './12/delay' u 1:2 t '' with linespoints lt 10 pt 9, \
     './13/delay' u 1:2 t '' with linespoints lt 12 pt 10, \
     './14/delay' u 1:2 t '' with linespoints lt 14 pt 11
    
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

