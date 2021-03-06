#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Time(s)"
set ylabel "Throghput(Kbps)"
#set key right bottom
set key right top Right
#set term postscript eps monochrome blacktext "Helvetica" 24
set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'throughput(8).eps'
set autoscale
set grid
set boxwidth 20
#set xrange [1:20]
#set yrange [:400]

plot    './HopsResultInst.txt(hops=8)' u 5:6 t 'hops=8' with linespoints, \
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

