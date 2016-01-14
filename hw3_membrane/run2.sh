gmx editconf -f dppc128.pdb -o dppc128.gro
gmx grompp -f minim.mdp -c dppc128.gro -p topol_dppc.top -o em.tpr
gmx trjconv -s em.tpr -f dppc128.gro -o dppc128_whole.gro -pbc mol -ur compact
#choose DPPC group
gmx editconf -f KALP-15_processed.gro -o KALP_newbox.gro -c -box 6.41840 6.44350 6.59650
cat KALP_newbox.gro dppc128_whole.gro > system.gro
# remove unneccessary lines
# add a new #ifdef statement to topology
