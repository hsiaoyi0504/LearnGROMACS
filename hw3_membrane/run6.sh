mv em.gro confout.gro
perl inflategro.pl confout.gro 0.95 DPPC 0 system_shrink1.gro 5 area_shrink1.dat
gmx grompp -f minim.mdp -c system_shrink1.gro -p topol.top -o em.tpr -maxwarn 1
gmx mdrun -v -deffnm em
