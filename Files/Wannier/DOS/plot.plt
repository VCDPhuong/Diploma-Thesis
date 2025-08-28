set terminal svg enhanced
set output "DoS.svg"
set xlabel "Energy (eV)"
set ylabel "Conductivity (S/cm)"
set xrange [10:15]
EF = 12.2534
set arrow from EF, graph 0 to EF, graph 1 nohead
plot "RuO2-dos.1.6.down.dat" u 1:2 w l t "d_{z^2}", \
     "RuO2-dos.2.7.down.dat" u 1:2 w l lc rgb "red" t "d_{xz}",\
     "RuO2-dos.3.8.down.dat" every 15 u 1:2 w l dt 2 t "d_{yz}",\
     "RuO2-dos.4.9.down.dat" u 1:2 w l t "d_{x^2-y^2}",\
     "RuO2-dos.5.10.down.dat" u 1:2 w l t "d_{xy}",\
     "RuO2-dos.total.down.dat" u 1:2 w l t "Total"