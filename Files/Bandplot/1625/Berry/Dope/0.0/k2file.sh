#!/bin/bash

# Simple k-point generator for Wannier90 calculations using local kmesh.pl
# Parameters
Nkx=16; Nky=16; Nkz=25
NUM_KPOINTS=$((Nkx * Nky * Nkz))

echo "Generating $NUM_KPOINTS k-points ($Nkx x $Nky x $Nkz) using kmesh.pl"

# Generate k-points using local kmesh.pl
/leonardo/home/userexternal/cvo00000/software/wannier90/utility/kmesh.pl $Nkx $Nky $Nkz > kpoints.list

# Check if k-point generation was successful
if [[ ! -s kpoints.list ]]; then
    echo "Error: k-point generation failed!"
    exit 1
fi

echo "K-points generated successfully"

# Update Wannier90 input file
echo "Updating RuO2.win with k-points..."
awk '
BEGIN { in_kpoints=0 }
/^begin kpoints/ { 
    print
    in_kpoints=1
    # Read and print k-points (skip first 2 lines of kpoints.list)
    NR_internal=0
    while ((getline line < "kpoints.list") > 0) {
        NR_internal++
        if (NR_internal > 2) {
            # Only print first 3 columns (kx, ky, kz) for Wannier90
            split(line, arr, " ")
            print arr[1], arr[2], arr[3]
        }
    }
    close("kpoints.list")
    next
}
/^end kpoints/ { 
    if (in_kpoints) { 
        print
        in_kpoints=0
        next
    }
}
!in_kpoints { print }
' RuO2_base.win > RuO2.win

# Update NSCF input file
echo "Updating RuO2.nscf with k-points..."
awk '
BEGIN { 
    # Read k-points file correctly
    getline header < "kpoints.list"     # "K_POINTS crystal"
    getline nkpts < "kpoints.list"      # "12800"
    kcount = 0
    while ((getline line < "kpoints.list") > 0) {
        kpoints[++kcount] = line
    }
    close("kpoints.list")
    in_kpoints=0
}
/^K_POINTS/ { 
    print header
    print nkpts
    for (i=1; i<=kcount; i++) print kpoints[i]
    in_kpoints=1
    next
}
in_kpoints && /^[0-9]/ {
    in_kpoints=0
    next
}
!in_kpoints { print }
' RuO2_base.nscf > RuO2.nscf

echo "Done! Generated $NUM_KPOINTS k-points"
echo "Files updated: RuO2.win, RuO2.nscf"

