set multiplot layout 3,2 columnsfirst \
	title "point LAS AV - 34 (lateral pull rod)"\
    spacing 0.5,0.5

set datafile sep ';'
set key box opaque
set autoscale
set grid
set format y "%.1f"
set format y2 "%.1f"


set style line 1 \
    linecolor 3 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0.5
	
set style line 2 \
    linecolor 1 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0.5
	
set ytics nomirror tc ls 1
set y2tics nomirror tc ls 2


set ylabel 'camber [deg]'
set y2label 'kingpin [deg]'
unset xlabel
unset key
plot "roll.csv" using 1:2 w lp ls 1 axes x1y1, "roll.csv" using 1:3 w lp ls 2 axes x1y2

set ylabel 'spindle length [mm]'
set y2label 'scrub radius [mm]'
plot "roll.csv" using 1:4 w lp ls 1 axes x1y1, "roll.csv" using 1:5 w lp ls 2 axes x1y2

set ylabel 'RC_y [mm]'
set y2label 'RC_z [mm]'
set xlabel 'roll [deg]'
plot "roll.csv" using 1:12 w lp ls 1 axes x1y1, "roll.csv" using 1:13 w lp ls 2 axes x1y2

set ylabel 'caster [deg]'
set y2label 'mechanical trail [mm]'
unset xlabel
unset key
plot "roll.csv" using 1:6 w lp ls 1 axes x1y1, "roll.csv" using 1:7 w lp ls 2 axes x1y2

set ylabel 'spring travel [mm]'
set y2label 'ARB travel [mm]'
plot "roll.csv" using 1:8 w lp ls 1 axes x1y1, "roll.csv" using 1:9 w lp ls 2 axes x1y2

set ylabel 'toe (SAE) [deg]'
set y2label 'antidive [-]'
set xlabel 'roll [deg]'
plot "roll.csv" using 1:10 w lp ls 1 axes x1y1, "roll.csv" using 1:11 w lp ls 2 axes x1y2


unset multiplot
