#!/bin/bash

ls -l | tail -4; echo "#-- local group_id Number:"; read a
b="$(LC_TIME=C date +%y%m%d_%a.%H%M)"
echo "#-- ls -l *[iek] | awk -F\"${a}\" '{print \"- D  \"$2}' | sed 's/*$//' > dn-00-local-${b}"
echo "#-- Oracle_VirtualBox_Extension_Pack-7.2.4.vbox-extpack 때문에 *[iek] 에 k 가 들어갑니다."
ls -l *[iek] | awk -F"${a}" '{print "- D  "$2}' | sed 's/*$//' > dn-00-local-${b}
echo "#-- sort -k7 -k2 0[abc]*t dn-00-local-${b} > dn-01-sort"
sort -k7 -k2 0[abc]*t dn-00-local-${b} > dn-01-sort
echo "#-- rm -f dn-00-local-${b}; vi dn-01-sort"
##rm -f dn-00-local-${b}
echo "#-- vi 에서 '/^- D ' 명령으로 찾고 같은 파일을 비교해서,"
echo "#-- 'S' 보다 'D' 가 나중이면 '-' 를 'o' 로 바꿉니다."
echo "#-- press Enter:"
read a
vi dn-01-sort
