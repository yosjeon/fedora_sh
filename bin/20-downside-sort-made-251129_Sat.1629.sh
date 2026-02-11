#!/bin/bash

grp_id=$(ls -l $0 | head -1 | awk '{print $4}')
ymdaHM="$(LC_TIME=C date +%y%m%d_%a.%H%M)"
download_list="dn-00-download_list"
rsync_marking="dn-01-rsync_marking-${ymdaHM}"

cat <<__EOF__
#-- (1) 현재 위치의 *[iek] 파일을 ${download_list} 에 자징힙니다.
#-- 실행파일의 확장자가 아래에 해당되는지 확인할것.
#-- [1] [2] [3] [4]
#--  .   e   x   e   (.exe)
#--  .   m   s   i   (.msi)
#--  p   a   c   k   (pack)
#--  .   z   i   p   (.zip)
#--  d   .   7   z   (d.7z)
#-- [1] [2] [3] [4]
#-- ls *[.pd][emz.][xsci7][eikpz]

-rwxr-xr-x 1 userid grpid 145735584 11월 29 13:15 CursorSetup-x64-2.1.39.exe
-rwxr-xr-x 1 userid grpid  18558944 11월 29 13:18 VC_redist.x64.exe
-rwxr-xr-x 1 userid grpid 115563048 11월 29 13:19 VSCodeUserSetup-x64-1.106.3.exe
-rwxr-xr-x 1 userid grpid 369012848 11월 29 13:20 postgresql-17.7-1-windows-x64.exe
__EOF__
ls *[.pd][emz.][xsci7][eikpz]

echo "#-- ls -l *[.pd][emz.][xsci7][eikpz] | awk -F\"${grp_id}\" '{print \"- D  \"$2}' | sed 's/*$//' > ${download_list}"
ls -l *[.pd][emz.][xsci7][eikpz] | awk -F"${grp_id}" '{print "- D  "$2}' | sed 's/ /\ /g' | sed 's/*$//' > ${download_list}

ls -l *[.pd][emz.][xsci7][eikpz] | awk -F"${grp_id}" '{print "- D  "$2}' | sort -k7 -k2 > ${download_list}


echo "#-- 이름이나 사이즈가 다르면 업로드를 위해 '- D' 를 'o D' 로 직접 바꿉니다." > ${rsync_marking}
echo "#-- sort -k7 -k2 0[abc]*t ${download_list} >> ${rsync_marking}"
sort -k7 -k2 0[abc]*t ${download_list} >> ${rsync_marking}

cat <<__EOF__
#-- rm -f ${download_list}; vi ${rsync_marking}
#--
#-- vi 에서, "/^- D " 명령으로 찾고, 같은 파일을 비교해서,
#-- 'S' 서버 보관과 'D' 지금 다운로드 의 파일이 서로 다르면,
#-- 업그레이드 된걸로 보고, '-' 를 'o' 로 직접 수정해야 합니다.
#-- press Enter:
__EOF__
read a

echo "#-- vi ${rsync_marking}"
vi ${rsync_marking}

echo "#-- Enter port2:"; read a
echo "#-- Enter user5:"; read b; c=""
for i in $(grep "^o D " ${rsync_marking} | awk '{print $7" "$8" "$9}')
do
	d=$(echo $i | sed 's/ /\\ /g'); c="$c \"$d\" "
done

grep "^o D " ${rsync_marking} | awk '{
    file_name = ""
    for (i = 7; i <= NF; i++) { # $7부터 마지막 필드까지를 합쳐서 출력
        if (i > 7) {
            file_name = file_name " " $i
        } else {
            file_name = $i
        }
    }
    print file_name
}' | while read -r filename; do
    echo "i= $filename"
done

echo "c=${c};"
rsync -avzr -e "ssh -p ${a}22" ${c} ${b}pi@pi:a*/m*/01-*/
