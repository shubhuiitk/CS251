set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",10"
set ytics font ",10"
set ylabel font ",10"
set xlabel font ",10"

#set format y "10^{%L}"
set xlabel "Random Sample"
set ylabel "EXP(10)"
set yrange[10:100000]
set logscale x
set logscale y
set xrange[10:10000000]
set ytic auto
set xtic auto


set output "exponential.eps"
plot 'threaddata.txt' every ::0::400 using 1:2 notitle with points pt 1 ps 1.5
plot 'threaddata.txt' every ::400::800 using 1:2 notitle with points pt 1 ps 1.5
plot 'threaddata.txt' every ::800::1200 using 1:2 notitle with points pt 1 ps 1.5
plot 'threaddata.txt' every ::1200::1600 using 1:2 notitle with points pt 1 ps 1.5
plot 'threaddata.txt' every ::1600::2000 using 1:2 notitle with points pt 1 ps 1.5


