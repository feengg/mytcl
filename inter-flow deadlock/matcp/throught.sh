#!/usr/bin/gnuplot
#set title "Instant Throughput (Tc=10,m=1)"
set xlabel "Time / s"
set ylabel "Throghput / kbps"
set key right bottom
# 黑白
#set term postscript eps monochrome blacktext "Helvetica" 24
#彩色
set term postscript eps enhanced color blacktext "Helvetica" 24

set output "Throughput(matcp).eps"
set autoscale
#set grid
set boxwidth 20
set xrange [0:200]

plot './HopsResultInst_flow0.txt' u 5:6 t 'flow0' with linespoints, \
    './HopsResultInst_flow1.txt' u 5:6 t 'flow1' with linespoints
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

