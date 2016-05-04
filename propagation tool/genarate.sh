#!/bin/bash

max=2000
distance=100

while [ $distance -lt $max ]; do
    ./threshold -m TwoRayGround -r $distance >> tmp.txt
    let distance=distance+50
done

gawk -f ./reduce.awk tmp.txt > threshold.txt

rm tmp.txt
