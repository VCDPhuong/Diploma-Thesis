set terminal pdf enhanced
set output "AHC_strained.pdf"

set title ""
set xlabel "k-path"
set ylabel "AHC (S/cm)"
set grid
set key top right

# === Fermi energy shift (Ry or eV) ===
EF = 13.1206

p "RuO2_up-ahc-fermiscan.dat" u 1:2 w l t "x-up", \
  "RuO2_dn-ahc-fermiscan.dat" u 1:2 w l t "x-down", \
  "RuO2_up-ahc-fermiscan.dat" u 1:3 w l t "y-up", \
  "RuO2_dn-ahc-fermiscan.dat" u 1:3 w l t "y-down", \
  "RuO2_up-ahc-fermiscan.dat" u 1:4 w l t "z-up", \
  "RuO2_dn-ahc-fermiscan.dat" u 1:4 w l t "z-down"

