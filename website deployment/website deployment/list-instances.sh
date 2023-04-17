#!/bin/bash

#a script to make the describe instances output look pretty

aws ec2 describe-instances | grep -E "InstanceId|"\"Name\":"|Value|"\"PublicIp\":"" > out.txt
sed 's/Name/State/g' out.txt > tmp.txt
sed 's/\"//g' tmp.txt > tmp1.txt
sed 's/\,//g' tmp1.txt > tmp2.txt

#python to left align and take out duplicate public ip
python3 aws-out.py

rm out.txt
rm pout.txt

declare -a output
mapfile -t output < instances.txt

lenarray=${#output[@]}
let numarrays=$lenarray/4
count=0

if [ $((lenarray%4)) == 0 ]; then
    spacing=4	
else
    spacing=3
fi

echo
echo instance ID, State, IP, tag
echo -------------------------
for i in "${output[@]}"; do 
    echo $i
    ((count=count+1))
    let x=$count%$spacing
    #echo $x
    if [ $((x%4)) == 0 ]; then
	    echo
    fi
done
echo -------------------------

#echo ${output[@]}
rm instances.txt
rm tmp.txt
rm tmp1.txt
rm tmp2.txt
