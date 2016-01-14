gmx editconf -f em.gro -bt dodecahedron -d 0.5 -o box.gro
gmx solvate -cp box.gro -cs spc216.gro -p topol.top -o solvated.gro
