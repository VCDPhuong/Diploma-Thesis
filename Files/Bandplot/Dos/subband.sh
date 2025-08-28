#!/usr/bin/bash
#SBATCH --time=24:00:00
#SBATCH --ntasks-per-node=40
#SBATCH --cpus-per-task=1
#SBATCH --job-name=bands 
#SBATCH --partition=dcgp_usr_prod
#SBATCH --qos=normal
#SBATCH --err=job.err
#SBATCH --out=job.out
#SBATCH --account=ICT25_CMSP
#SBATCH --mail-user=vanlostreangthe@gmail.com
#SBATCH --mail-type=ALL

module purge
module load profile/chem-phys
module load fftw/3.3.10--openmpi--4.1.4--gcc--11.3.0
module load quantum-espresso/7.2--openmpi--4.1.4--gcc--11.3.0-openblas

mpirun -np 40 pw.x -ndiag 40 < RuO2.scf >> scf.out

#nscf
mpirun -np 40 pw.x -ndiag 40 < RuO2.nscf >> nscf.out
projwfc.x < projwfc.in > total/projwfc.out
projwfc.x < projk.in > kresolve/projwfc.out

PREFIX="RuO2"
OUTDIR="./tmp"
FILE="RuO2_bands"

###=== spin-resolved postprocessing ===###

for i in 1 2 ; do

cat > $FILE-sp$i.in << EOF
&BANDS
   prefix = '$PREFIX'
   outdir='$OUTDIR',
   filband = '$FILE-sp$i.dat'
   spin_component = $i
/
EOF

bands.x < $FILE-sp$i.in  > $FILE-sp$i.out

done
