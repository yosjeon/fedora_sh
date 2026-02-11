#!/bin/bash

echo "#-- Enter port 22:"; read a
echo "#-- Enter user pi"; read b; c=""
for i in $(grep "^o D " dn-01-sort | awk '{print $7}')
do
    c="$c $i "
done
echo "#-- rsync -avzr -e \"ssh -p $a\" $c $b@pi:a*/m*/01-*/"
echo "#-- press Enter: "; read xxx
rsync -avzr -e "ssh -p $a" $c $b@pi:a*/m*/01-*/
