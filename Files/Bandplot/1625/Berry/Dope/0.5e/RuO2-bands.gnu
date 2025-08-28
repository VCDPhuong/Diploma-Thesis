set terminal pdfcairo enhanced color solid
set output "RuO2-bands.pdf"
set title "Band structure of RuO2"
set xlabel "k-point"
set ylabel "Energy (eV)"
set grid ytics
set grid xtics
set arrow from       0.69190456,      3.46084089 to       0.69190456,     19.40455851 nohead
set arrow from       1.91037662,      3.46084089 to       1.91037662,     19.40455851 nohead
set arrow from       2.88887743,      3.46084089 to       2.88887743,     19.40455851 nohead
set arrow from       3.89184415,      3.46084089 to       3.89184415,     19.40455851 nohead
set arrow from       4.87034496,      3.46084089 to       4.87034496,     19.40455851 nohead
set arrow from       5.87331168,      3.46084089 to       5.87331168,     19.40455851 nohead
set style data dots
unset key
set xrange [0: 6.85181]
set yrange [      3.46084089 :     19.40455851]
set xtics (" G "  0.00000," X "  0.69190," A "  1.91038," Z "  2.88888," G "  3.89184," M "  4.87034," A "  5.87331," Z "  6.85181)
 plot "RuO2-bands.dat"
