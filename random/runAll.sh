#!/bin/bash

str=`pwd`
echo "current directory is: " $str

echo "type any key to continue..."
read c

cd ./matcp
./mobility.sh 
#cd ../newreno
#./chain.sh

cd ../semitcp
./mobility.sh
#cd ../tcpap
#./chain.sh 

cd ../
./throughput.sh
./delay.sh
