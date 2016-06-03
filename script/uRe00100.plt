#Template for gnuplot     2016.06.04
#
#---- Title ----
set title 'Re = 100' font 'Arial, 24'
#
#---- Axis caption ----
#
set xlabel 'y' font 'Arial, 20'
set ylabel 'u-velocity' font 'Arial, 20'
#---- Axis format ----
set format x "%3.1f"
set format y "%3.1f"
#
#---- Length & scale ---
set size 0.7,0.7
#
#---- Aspect ratio ----
set size ratio 0.77
#
#---- Range of x & y ----
set xrange [ 0 : 1 ]
set yrange [ -0.4 : 1 ]
#
set xtics 0.2
set ytics 0.2
#
#---- Start position of legend ----
set key reverse
set key left top
#
#---- Insert text ----
#set label "abc"  at  2,3 center
#set label "123"  at  2,4 center
#
#---- Arrow ----
#set arrow  from  0,0 to 0.5,1.0 nohead
#
#---- Grid ----
#set grid
#
#---- Line style ----
set style line 1 lt 1 lw 2 pt 1
set style line 2 lt 2 lw 2 pt 2
set style line 3 lt 3 lw 2 pt 3
set style line 4 lt 4 lw 2 pt 4
set style line 5 lt 5 lw 2 pt 5
#
#---- Plot graph on terminal ----
#
set terminal X11
plot 'cavityRe00100/postProcessing/sets/100/lineY1_U.xy' \
     usi 1:2 ti 'icoFoam' ls 1 w l, \
     'Ghia/u-vel.dat' usi 2:3 ti 'Ghia et al.' ls 2 w p

pause -1 "Hit return key  "

#---- Output esp file ----
set terminal postscript eps enhanced
set output "uRe00100.eps"
replot

#---- Output SVG file ----
#set terminal svg
#set output "uRe00100.svg"
#replot
