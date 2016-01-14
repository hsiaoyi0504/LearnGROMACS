gmx grompp -f ions.mdp -c solvated.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o system_solv_ions.gro -p topol.top -pname NA -nname CL -nn 4
gmx grompp -f minim2.mdp -c system_solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
