#!/bin/bash

n=$1
if ! [[ $n =~ ^-?[0-9]+$ ]];
then
echo "Not a number"
elif (( n % 15 == 0 )); then
	echo "tomcat"
elif (( n % 3 == 0 )); then
	echo "tom"
elif (( n % 5 == 0 )); then
	echo "cat"
else
	echo "invalid"
fi
