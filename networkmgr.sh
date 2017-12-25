#!/bin/bash

echo "Please select an SSID to connect to:"

# declare the array name
declare -a networks

incriment=0

# store number of lines in variable currently not used for anything
#lines=$(iw dev wlo1 scan | grep SSID: | xargs -n1 | wc -l)

SSID="SSID:"

# get the list of network ssids and store in array
mapfile -t networks < <(iw dev wlo1 scan | grep SSID: | sed s/SSID:// | sed /^[[:space:]]*$/d | xargs -n1 echo)

# get the length of "$networks"
arraylength=${#networks[@]}

#echo ${networks[*]}

#&& incriment=$((incriment+1)))
#networks[$incriment]= 

for i in "${networks[@]}"
do
	echo "$incriment: SSID: ${i}"
	incriment=$((incriment+1))
done

echo "Please Select SSID:"
read selection
echo "Please enter password:"
read password

nmcli dev wifi connect ${networks[$selection]} password $password

echo $selection
echo $password
