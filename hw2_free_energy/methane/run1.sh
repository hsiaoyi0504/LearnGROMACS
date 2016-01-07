#!/bin/sh

lambdas=( 0 0.2 0.4 0.5 0.6 0.8 0.9 1 )

cd lambda_0

for i in "${lambdas[@]}"; do
    echo ""
    echo "Start calculation of lambda ${i}"
    echo ""
    cd ../$MYDIR/lambda_$i
    gmx grompp
    gmx mdrun -v -nt 1
    echo ""
    echo "Finished caculation of lambda ${i}"
done

