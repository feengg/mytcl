#!/bin/bash

str=`pwd`
echo "current directory is: " $str

cd ./matcp
./chain.sh &
cd ../newreno\(d\)
./chain.sh

cd ../newreno\(m\)
./chain.sh &

cd ../semitcp
./chain.sh
#cd ../tcpap
#./chain.sh 

cd ../
./throughput.sh 
./delay.sh
