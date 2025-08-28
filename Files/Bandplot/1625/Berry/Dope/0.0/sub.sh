#!/usr/bin/bash
#SBATCH --time=24:00:00
#SBATCH --ntasks-per-node=40
#SBATCH --cpus-per-task=1
#SBATCH --job-name=Wannierization
#SBATCH --partition=dcgp_usr_prod
#SBATCH --qos=normal
#SBATCH --err=job.err
#SBATCH --out=job.out
#SBATCH --account=ICT25_CMSP
##SBATCH --mail-user=vanlostreangthe@gmail.com
##SBATCH --mail-type=ALL

module purge
module load profile/chem-phys
module load fftw/3.3.10--openmpi--4.1.4--gcc--11.3.0
module load quantum-espresso/7.2--openmpi--4.1.4--gcc--11.3.0-openblas

# Suppress CUDA warnings
export OMPI_MCA_opal_warn_on_missing_libcuda=0

export OMP_NUM_THREADS=1
#scf
mpirun -np 40 pw.x -ndiag 40 < RuO2.scf >> scf.out
#gen k and update into file
bash k2file.sh

#pre-processing Wannier

#nscf
mpirun -np 40 pw.x -ndiag 40 < RuO2.nscf >> nscf.out
#projwfc.x < projwfc.in > projwfc.out 
#port to Wannier

wannier90.x -pp RuO2 

mpirun -np 32 pw2wannier90.x < RuO2.pw2wan > pw2wan.out #should using the q-e pw2wannier90.x in personal solfware directory
# The current version on Cineca have a bug in handling big number of k-points, which have been fixed in the dev version on gitlab.

# Clean up any existing error files and temp directories
#rm -f *.werr *.chk

# Run Wannier90 serially to avoid MPI file conflicts
wannier90.x RuO2
