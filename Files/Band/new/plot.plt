set terminal pdfcairo dashed enhanced
set termoption dash
set output "Bandstructure_marked.pdf"
set size 0.3,1

set title "RuO_2 Band Structure"
set xlabel "k-path"
set ylabel "Energy (eV)"
set grid
set key top right

# === Fermi energy shift (Ry or eV) ===
EF = 12.2534
set yrange [-5:8]    # Adjust as needed
set xrange [3.639:4.3638]  # Adjust as needed
# === Tick labels for high-symmetry points ===
# Accurate cumulative k-path distances
# Distances between k-points (GX segment normalized to 0.5)
# Distances between high-symmetry points in k-space:
# R to Y: 0.7248
# Y to G: 0.5
# G to X: 0.5
# X to M: 0.5
# M to G: 0.7071
# G to M': 0.7071
# M' to A': 0.7248
# A' to Z: 0.7071
# Z to R: 0.5
# R to A: 0.5
set xtics ("R" 0.0000, \
		   "Y" 0.7248, \
		   "{/Symbol G}" 1.2248, \
		   "X" 1.7248, \
		   "M" 2.2248, \
		   "{/Symbol G}" 2.9319, \
		   "M'" 3.639, \
		   "A'" 4.3638, \
		   "Z" 5.0709, \
		   "R'" 5.5709, \
		   "A" 6.0709)
# === Vertical lines at symmetry points ===
set arrow from 0.7248, graph 0 to 0.7248, graph 1 nohead lt -1 lw 1
set arrow from 1.2248, graph 0 to 1.2248, graph 1 nohead lt -1 lw 1
set arrow from 1.7248, graph 0 to 1.7248, graph 1 nohead lt -1 lw 1
set arrow from 2.2248, graph 0 to 2.2248, graph 1 nohead lt -1 lw 1
set arrow from 2.9319, graph 0 to 2.9319, graph 1 nohead lt -1 lw 1
set arrow from 3.639, graph 0 to 3.639, graph 1 nohead lt -1 lw 1
set arrow from 4.3638, graph 0 to 4.3638, graph 1 nohead lt -1 lw 1
set arrow from 5.0709, graph 0 to 5.0709, graph 1 nohead lt -1 lw 1
set arrow from 5.5709, graph 0 to 5.5709, graph 1 nohead lt -1 lw 1
set arrow from 6.0709, graph 0 to 6.0709, graph 1 nohead lt -1 lw 1
set object 1 circle center 3.92,0.15 radius 0.04 front lw 2 fillstyle empty border lc rgb "red"




# === Plot both spin channels ===
plot 'RuO2_bands-sp1.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "blue" notitle, \
     'RuO2_bands-sp2.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "blue" notitle #, \
     #'up/RuO2_band.dat'       using (column(1)*4.5886/6.34971):(column(2) - EF) w lines lt 1 lw 2 dashtype 2 lc rgb "red" title "Wannier", \
     #'down/RuO2_band.dat'     using (column(1)*4.5886/6.34971):(column(2) - EF) w lines lt 1 lw 2 dashtype 2 lc rgb "red" notitle