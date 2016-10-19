#!/usr/bin/gnuplot
#set title "SemiTcp, TCP-AP and TCP Throughput, 9 hops"
set xlabel "Time(s)"
set ylabel "Time(ms)"
set y2label "Throughput(kbps)"

set y2tics
set ytics nomirror

set title "send\\_time vs inst\\_thrghpt"

#set key right bottom
set key left top left
set term postscript eps monochrome blacktext "Helvetica" 16
#set term postscript eps enhanced color blacktext "Helvetica" 16
set output 'send_time_and_inst.eps'
set autoscale
set grid
set boxwidth 20
set xrange [:10]
set yrange [:25]
#set y2range　[100:400]

plot    './send_time_vec' u 1:2 t 'send\_time' with linespoints axis x1y1 lt 3, \
        './HopsResultInst.txt' u 5:6 t 'inst\_thrghpt' with linespoints axis x1y2 lt 5
    
    set output
quit

   
#set tmargin 0
#set bmargin 0
   
#set term post eps enhan "Helvetica" 60   
#set out "combine-curve-time.eps"
#set nomultiplot

