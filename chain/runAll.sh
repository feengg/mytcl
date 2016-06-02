#!/bin/bash

str=`pwd`
echo "current directory is: " $str

cd matcp
./chain.sh 
#cd ../newreno
#./chain.sh

#cd ../semitcp
#./chain.sh
#cd ../tcpap
#./chain.sh 

cd ../
./throughput.sh
./delay.sh

echo "all jobs are finished, type any key to exit..."
read c
