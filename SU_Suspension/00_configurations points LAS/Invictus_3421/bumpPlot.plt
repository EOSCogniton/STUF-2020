set multiplot layout 3,2 columnsfirst \
	title " Invictus3420 - v01 (rear is dashed)"\
    spacing 0.5,0.5

set datafile sep ';'
set key box opaque
set autoscale
set grid
set format y "%.2f"
set format y2 "%.2f"


set style line 1 \
    linecolor 3 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0
	
set style line 2 \
    linecolor 1 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0
	
set style line 3 \
    linecolor 3 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0\
	dashtype 2
	
set style line 4 \
    linecolor 1 \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0\
	dashtype 2
	
set ytics nomirror tc ls 1
set y2tics nomirror tc ls 2


set ylabel 'camber [deg]' tc ls 1
set y2label 'kingpin [deg]' tc ls 2
unset xlabel
unset key
plot "bumpAV.csv" using 1:2 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:3 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:2 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:3 w lp ls 4 axes x1y2

set ylabel 'spindle length [mm]'
set y2label 'scrub radius [mm]'
plot "bumpAV.csv" using 1:4 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:5 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:4 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:5 w lp ls 4 axes x1y2

set ylabel 'RC_y [mm]'
set y2label 'RC_z [mm]'
set xlabel 'bump [mm]'
plot "bumpAV.csv" using 1:12 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:13 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:12 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:13 w lp ls 4 axes x1y2

set ylabel 'caster [deg]'
set y2label 'mechanical trail [mm]'
unset xlabel
unset key
plot "bumpAV.csv" using 1:6 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:7 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:6 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:7 w lp ls 4 axes x1y2

set ylabel 'spring travel [mm]'
set y2label 'ARB travel [mm]'
plot "bumpAV.csv" using 1:8 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:9 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:8 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:9 w lp ls 4 axes x1y2

set ylabel 'toe (SAE) [deg]'
set y2label 'antidive [-]'
set xlabel 'bump [mm]'
plot "bumpAV.csv" using 1:10 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:11 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:10 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:11 w lp ls 4 axes x1y2


unset multiplot
