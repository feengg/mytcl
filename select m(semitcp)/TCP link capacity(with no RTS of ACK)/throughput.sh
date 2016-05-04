#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "m"
set ylabel "Throghput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput.eps'
set autoscale
set grid
set boxwidth 20
#set yrange [140:400]

plot    './throughput(node=22)' u 1:2 t 'node=22' with linespoints, \
        './throughput(node=23)' u 1:2 t 'node=23' with linespoints, \
        './throughput(node=24)' u 1:2 t 'node=24' with linespoints, \
        './throughput(node=25)' u 1:2 t 'node=25' with linespoints


set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

