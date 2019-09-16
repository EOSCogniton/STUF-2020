set multiplot layout 3,2 columnsfirst \
	title "point LAS AV\_1 (top pushrod)"\
    spacing 0.5,0.5

set datafile sep ';'
set key box opaque
set autoscale
set grid

set ylabel 'camber [deg]'
unset xlabel
unset key
plot "bump.csv" using 1:2 with linespoints

set ylabel 'toe (SAE) [deg]'
plot "bump.csv" using 1:3 w lp

set ylabel 'castor [deg]'
set xlabel 'bump [mm]'
plot "bump.csv" using 1:4 w lp

set ylabel 'kingpin [deg]'
unset xlabel
plot "bump.csv" using 1:5 w lp

set ylabel 'spring travel [mm]'
plot "bump.csv" using 1:6 w lp

set ylabel 'anti-dive [%]'
set xlabel 'bump [mm]'
plot "bump.csv" using 1:7 w lp

unset multiplot
