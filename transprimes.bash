#!/bin/bash

n_cols=$(tput cols)
n_rows=$(tput lines)
n=$[n_rows * n_cols]
n_stripe=$(($n_rows / 5 * $n_cols))

digits=`printf "00" && printf "1%.0s" $(seq 1 1 $[n-2])}`
max_d=$(echo "sqrt($n)" | bc)
for ((d=2; d<max_d; d++))
do
    if [[ ${digits:$d:1} -eq 1 ]]
    then
        for ((x=d*2; x<n; x += d))
        do
            digits=${digits:0:$[x]}0${digits:$[x+1]}
        done
    fi
done

blue='\e[38;5;74m'
pink='\e[38;5;175m'
white='\e[38;5;255m'

i=0
for set_color in $blue $pink $white $pink $blue
do
    printf "$set_color%s" ${digits:$i:$n_stripe}
    ((i += n_stripe))
done
