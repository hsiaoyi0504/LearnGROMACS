gmx make_ndx -f em.gro -o index.ndx
#enter "16 | 14" to merge the SOL and CL groups & "1 | 13’’ to merge Protein and DPPC)
gmx grompp -f nvt.mdp -c em.gro -p topol.top -n index.ndx -o nvt.tpr
gmx mdrun -deffnm nvt
rm nvt.tpr
rm nvt.trr
#rm nvt.edr
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -n index.ndx -o npt.tpr
gmx mdrun -deffnm npt
rm npt.tpr
rm npt.trr
#rm npt.edr
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -n index.ndx -o md.tpr
gmx mdrun -deffnm md
