set terminal pdf enhanced
set output "RuO2_Strain.pdf"

set title "RuO_2 Strained Band Structure"
set xlabel "k-path"
set ylabel "Energy (eV)"
set grid
set key top right
set size 0.3,1
# === Fermi energy shift (Ry or eV) ===
EF = 13.1206
set yrange [-5:8]    # Adjust as needed
set xrange [3.636:4.3638] # Adjust as needed
# === Tick labels for high-symmetry points ===
# Accurate cumulative k-path distances
# Distances between k-points (GX segment normalized to 1.0)
# Distances between high-symmetry points in k-space:
# R to Y: 0.722
# Y to G: 0.49
# G to X: 0.515
# X to M: 0.49
# M to G: 0.71
# G to M': 0.71
# M' to A': 0.722
# A' to Z: 0.71
# Z to R: 0.515
# R to A: 0.49
set xtics ("R" 0, "Y" 0.722, "{/Symbol G}" 1.212, "X" 1.727, "M" 2.217, "{/Symbol G}" 2.927, "M'" 3.637, "A'" 4.359, "Z" 5.069, "R'" 5.584, "A" 6.074)

# === Vertical lines at symmetry points ===
set arrow from 0.722, graph 0 to 0.722, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 1.212, graph 0 to 1.212, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 1.727, graph 0 to 1.727, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 2.217, graph 0 to 2.217, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 2.927, graph 0 to 2.927, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 3.637, graph 0 to 3.637, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 4.359, graph 0 to 4.359, graph 1 nohead lt 1 lw 1 lc rgb "black"
set arrow from 5.069, graph 0 to 5.069, 5 nohead lt 1 lw 1 lc rgb "black"
set arrow from 5.584, graph 0 to 5.584, 5 nohead lt 1 lw 1 lc rgb "black"
set object 1 circle center 4.22,0.0 radius 0.04 front lw 2 fillstyle empty border lc rgb "red"



# === Plot both spin channels ===
plot 'RuO2_bands-sp1.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "blue" title "DFT", \
     'RuO2_bands-sp2.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "blue" notitle