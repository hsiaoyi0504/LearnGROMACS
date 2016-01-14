gmx grompp -f minim.mdp -c system_inflated.gro -p topol.top -o em.tpr -maxwarn 1
gmx mdrun -v -deffnm em
