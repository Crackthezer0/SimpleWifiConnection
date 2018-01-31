#!/bin/bash

echo "Please select an SSID to connect to:"

# declare the array name
declare -a networks

# Startign value which will be used for selecting networks
incriment=0

# store number of lines in variable currently not used for anything
#lines=$(iw dev wlo1 scan | grep SSID: | xargs -n1 | wc -l)

# Find the name of a wifi device to use
#device=ip link show | grep 3:

# get the list of network ssids and store in array
mapfile -t networks < <(iw dev wlo1 scan | grep SSID: | sed s/SSID:// | sed /^[[:space:]]*$/d | xargs -n1 echo)

# get the length of "$networks"
#arraylength=${#networks[@]}

#&& incriment=$((incriment+1)))
#networks[$incriment]= 

# for loop which iterates for every position in array
for i in "${networks[@]}"
do
	# print each network name in the array along with a corresponding number
	echo "$incriment: SSID: ${i}"
	# incriment number which will correspond with network name
	incriment=$((incriment+1))
done

# Ask the user to sellect a network by choosing a corresponding number
echo -n "Please Select SSID:"
read selection
# Ask the user to enter the password for the selected network
echo -n "Please enter password:"
read password

nmcli dev wifi connect ${networks[$selection]} password $password

echo $selection
echo $password
