#!/bin/sh

if [ $#  -lt 3 ]; then
    echo "Usage: mklambdas.sh grompp.mdp topol.top conf.gro"
    echo
    echo "Makes directories with given mdp file, topology, and configuration"
    echo "Replaces \$LAMBDA\$ in mdp file with current lambda values"
    echo "Replaces \$ALL_LAMBDAS\$ in mdp file with list of current lambda values"
    exit 1
fi

lambdas_state=( 0 1 2 3 4 5 6 7 8 9 )
lambdas=( 0 0.2 0.4 0.5 0.6 0.65 0.7 0.8 0.95 1 )

all=${lambdas[@]}

for i in "${lambdas_state[@]}"; do
    newdir="lambda_${lambdas[i]}"
    echo "Making directory $newdir, and populating it"
    mkdir -p $newdir
    # now do the substitution
    sed "s/\\\$LAMBDA\\\$/${i}/" $1 > $newdir/grompp.mdp
    cp $2 $newdir/topol.top
    cp $3 $newdir/conf.gro
done

