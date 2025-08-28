set terminal pdfcairo enhanced
set output "AHC.pdf"
set xlabel "Energy (eV)"
set ylabel "Conductivity (S/cm)"
plot "50/RuO2-ahc-fermiscan.up.dat" u 1:2 w l t "50",\
        "75/RuO2-ahc-fermiscan.up.dat" u 1:2 w l t "75",\
        "100/RuO2-ahc-fermiscan.up.dat" u 1:2 w l t "100",\
        "125/RuO2-ahc-fermiscan.up.dat" u 1:2 w l t "125",\
        "150/RuO2-ahc-fermiscan.up.dat" u 1:2 w l t "150"