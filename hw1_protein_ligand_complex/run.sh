# clean backup files
for i in {1..5}
do
	find . -name '*.'$i'#' -delete
done
find . -name 'temp.*' -delete
# generate topology file
gmx pdb2gmx -f 1aki_remove_water.pdb -water spce -ff oplsaa -o 1AKI_processed.gro
gmx editconf -f 1AKI_processed.gro -o 1AKI_newbox.gro -c -d 1.0 -bt cubic
gmx solvate -cp 1AKI_newbox.gro -cs spc216.gro -o 1AKI_solv.gro -p topol.top
gmx grompp -f ions.mdp -c 1AKI_solv.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o 1AKI_solv_ions.gro -p topol.top -pname NA -nname CL -nn 8
#choose group 13 (SOL)
gmx grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx energy -f em.edr -o potential.xvg
# At the prompt, type "10 0" to select Potential (10); zero (0) terminates input. 
gmx grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt
gmx energy -f nvt.edr -o temperature.xvg
# Type "15 0" at the prompt to select the temperature of the system and exit
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt
gmx energy -f npt.edr -o pressure.xvg
# Type "16 0" at the prompt to select the pressure of the system and exit
gmx energy -f npt.edr -o density.xvg
# Type "22 0" at the prompt to select the pressure of the system and exit
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md_0_1.tpr
gmx mdrun -deffnm md_0_1
# or use GPU
# gmx mdrun -deffnm md_0_1 -nb gpu
gmx trjconv -s md_0_1.tpr -f md_0_1.xtc -o md_0_1_noPBC.xtc -pbc mol -ur compact
# Select 0 ("System") for output
gmx rms -s md_0_1.tpr -f md_0_1_noPBC.xtc -o rmsd.xvg -tu ns
# Choose 4 ("Backbone") for both the least squares fit and the group for RMSD calculation.
gmx rms -s em.tpr -f md_0_1_noPBC.xtc -o rmsd_xtal.xvg -tu ns
gmx gyrate -s md_0_1.tpr -f md_0_1_noPBC.xtc -o gyrate.xvg
