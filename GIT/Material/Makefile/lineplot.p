#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",10"

set xtics font ",10"
set ytics font ",10"
set ylabel font ",10"
set xlabel font ",10"

set xlabel "No. of elements"
set ylabel "Mean of Time taken"
set logscale x
set logscale y
set yrange[10:100000]
set xrange[10:10000000]
set ytic auto
set xtic auto

set key bottom right

set output "mean.eps"
plot 'mean.txt'  using 1:2 title "1 thread" with linespoints, \
     '' using 1:3 title "2 threads" with linespoints pt 5 lc 4,\
     '' using 1:4 title "4 threads" with linespoints lc 3, \
     '' using 1:5 title "8 threads" with linespoints lc 2,\
     '' using 1:6 title "16 threads" with linespoints lc 6,\
