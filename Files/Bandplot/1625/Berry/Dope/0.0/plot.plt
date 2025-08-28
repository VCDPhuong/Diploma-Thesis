set terminal svg enhanced
set output "RuO2_bandstructure.svg"

set title "$RuO_2$ Band Structure (Spin-Resolved)"
set xlabel "k-path"
set ylabel "Energy (eV)"
set grid
set key top right

# === Fermi energy shift (Ry or eV) ===
#EF = 12.2536
EF = 0.0
set yrange [0:20]    # Adjust as needed

# === Tick labels for high-symmetry points ===
# Accurate cumulative k-path distances
set xtics ("G" 0.0000, \
           "X" 0.5000, \
           "R" 1.2248, \
           "Z" 1.7248, \
           "G" 2.4496, \
           "M" 3.1567, \
           "A" 3.8814, \
           "Z" 4.5886)


# === Vertical lines at symmetry points ===
set arrow from 0.5000, graph 0 to 0.5000, graph 1 nohead lt -1 lw 1
set arrow from 1.2248, graph 0 to 1.2248, graph 1 nohead lt -1 lw 1
set arrow from 1.7248, graph 0 to 1.7248, graph 1 nohead lt -1 lw 1
set arrow from 2.4496, graph 0 to 2.4496, graph 1 nohead lt -1 lw 1
set arrow from 3.1567, graph 0 to 3.1567, graph 1 nohead lt -1 lw 1
set arrow from 3.8814, graph 0 to 3.8814, graph 1 nohead lt -1 lw 1
set arrow from 4.5886, graph 0 to 4.5886, graph 1 nohead lt -1 lw 1



# === Plot both spin channels ===
plot 'RuO2_bands-sp1.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "black" title "Spin up",\
     'RuO2_band.dat' using (column(1)*(4.5886/6.34971)):(column(2) - EF) with lines lt 1 lw 1 lc rgb "red" title "Wannier"
