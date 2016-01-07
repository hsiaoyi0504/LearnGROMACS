# Random Insertion
gmx insert-molecules -ci chx.gro -nmol 466 -box 4.30795 4.30795 4.30795 -o chx_box.gro
# Specific Insertion
# gmx genconf -f chx.gro -nbox 8 8 8 -o chx_box.gro
gmx grompp -f minim.mdp -c chx_box.gro -p chx.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f nvt.mdp -c em.gro -p chx.top -o nvt.tpr
gmx mdrun -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -p chx.top -o npt.tpr
gmx mdrun -deffnm npt
gmx editconf -f npt.gro -o chx_newbox.gro -box 4.30795 4.30795 8.6159 -center 2.153975 2.153975 2.153975
gmx solvate -cp chx_newbox.gro -cs spc216.gro -p chx.top -o chx_solv.gro
gmx editconf -f peptide.gro -o peptide_newbox.gro -box 4.30795 4.30795 8.6159 -center 2.153975 2.153975 6.461925
gmx solvate -cp peptide_newbox.gro -cs chx_newbox.gro -o peptide_chx.gro


