#!/bin/sh

lambdas=( 0.65 0.7 0.8 0.95 1 )

for i in "${lambdas[@]}"; do
    echo ""
    echo "Start calculation of lambda ${i}"
    echo ""
    cd lambda_$i
    gmx grompp
    gmx mdrun -v -nt 1
    echo ""
    echo "Finished caculation of lambda ${i}"
    cd ..
done

