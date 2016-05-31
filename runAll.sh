#!/bin/bash

str=`pwd`
echo "current directory is: " $str

cd ./chain
./runAll.sh &

cd ../cross
./runAll.sh

cd ../parellel
./runAll.sh &

cd ../spindle
./runAll.sh

echo "all jobs are finished, type any key to exit..."
read c
