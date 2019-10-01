set multiplot layout 4,3 columnsfirst \
	title "point LAS AV - 32 (lateral pull rod)"\
    spacing 0.5,0.5

set datafile sep ';'
set key box opaque
set autoscale
set grid
set format y "%.2f"

set ylabel 'camber [deg]'
unset xlabel
unset key
plot "roll.csv" using 1:2 with lp

set ylabel 'toe (SAE) [deg]'
plot "roll.csv" using 1:3 w lp

set ylabel 'castor [deg]'
plot "roll.csv" using 1:4 w lp


set ylabel 'kingpin [deg]'
set xlabel 'roll [deg]'
plot "roll.csv" using 1:5 w lp

set ylabel 'spring travel [mm]'
unset xlabel
plot "roll.csv" using 1:6 w lp

set ylabel 'anti-dive [%]'
plot "roll.csv" using 1:7 w lp

set ylabel 'scrub [mm]'
plot "roll.csv" using 1:8 w lp

set ylabel 'mechanical trail [mm]'
set xlabel 'roll [deg]'
plot "roll.csv" using 1:9 w lp

set ylabel 'RC_y [mm]'
unset xlabel
plot "roll.csv" using 1:10 w lp

set ylabel 'RC_z [mm]'
set xlabel 'roll [deg]'
plot "roll.csv" using 1:11 w lp

unset multiplot
