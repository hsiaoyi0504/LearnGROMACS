rm *.log
rm *.*#
gmx editconf -f methane.gro -o box.gro -bt dodecahedron -d 1 -c
gmx solvate -cp box.gro -cs spc216.gro -o solv.gro -p topol.top
gmx grompp -f em_flexible.mdp -c solv.gro -p topol.top -o em_flexible.tpr
gmx mdrun -v -deffnm em_flexible
gmx grompp -f em.mdp -c solv.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em -nt 1
gmx grompp -f equil.mdp -c em.gro -p topol.top -o equil.tpr
gmx mdrun -v -deffnm equil -nt 1
sh mklambdas.sh md.mdp topol.top equil.gro
sh run1.sh
gmx bar -f lambda_*/dhdl.xvg -o -oi -oh > bar.txt

