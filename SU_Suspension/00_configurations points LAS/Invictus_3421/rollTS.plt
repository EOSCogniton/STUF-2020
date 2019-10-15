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
unset key
set xlabel 'roll [deg]'


set ylabel 'toe (SAE) [deg]'
set y2label 'antidive [-]'
plot "bumpAV.csv" using 1:12 w lp ls 1 axes x1y1, "bumpAV.csv" using 1:13 w lp ls 2 axes x1y2,\
	"bumpAR.csv" using 1:12 w lp ls 3 axes x1y1, "bumpAR.csv" using 1:13 w lp ls 4 axes x1y2


