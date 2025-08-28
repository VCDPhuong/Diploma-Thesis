set terminal pdfcairo enhanced
set output "0.5e.pdf"

set title "0.5 e/unit cell"
set xlabel "k-path"
set ylabel "Energy (eV)"
set grid
set key top right

# === Fermi energy shift (Ry or eV) ===
#EF = 12.1695
EF = 0
set yrange [3:20]    # Adjust as needed

# === Tick labels for high-symmetry points ===
# Accurate cumulative k-path distances
set xtics ("{/Symbol G}" 0.0000, \
           "X" 0.5000, \
           "R" 1.2248, \
           "Z" 1.7248, \
           "{/Symbol G}" 2.4496, \
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
plot 'Dopedata/0.0.sp1.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "red" title "Spin up", \
     'Dopedata/0.0.sp2.dat.gnu' using 1:(column(2) - EF) with lines lt 1 lw 1 lc rgb "blue" title "Spin down"
