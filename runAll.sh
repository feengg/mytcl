#!/bin/bash

str=`pwd`
echo "current directory is: " $str

cd ./chain
./runAll.sh

cd ../chain\(rt-fail\)
./runAll.sh

cd ../cross
./runAll.sh

cd ../cross\(rt-fail\)
./runAll.sh

cd ../parellel
./runAll.sh

cd ../parellel\(rt-fail\)
./runAll.sh

cd ../spindle
./runAll.sh

cd ../spindle\(rt-fail\)
./runAll.sh

cd ../random
./runAll.sh

echo "all jobs are finished, type any key to exit..."
read c
