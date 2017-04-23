#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Mobility speed (m/s)"
set ylabel "Delay (ms)"
set key left top reverse
set term postscript eps monochrome blacktext "Helvetica" 20
#set term postscript eps enhanced color blacktext "Helvetica" 24
set output 'delay.eps'
set autoscale
set grid

#set yrange [:750]
set boxwidth 20

plot    './semitcprc/delay' u 1:2 t 'Semi-TCP with algorithm 1' with linespoints lt 3 pt 4, \
        './semitcp/delay' u 1:2 t 'Semi-TCP without algorithm 1' with linespoints lt 5 pt 6, \
        './tcpap/delay' u 1:2 t 'TCP-AP' with linespoints lt 1 pt 2
	
set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

