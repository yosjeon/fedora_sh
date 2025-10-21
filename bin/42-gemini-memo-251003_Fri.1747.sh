#!/bin/sh

date_ymd=$(date +%y%m%d) #-- 250524
date_a=$(LC_TIME=C date +%a) #-- Sat
date_HM=$(date +%H%M) #-- 1533
ymd_mdHM="${date_ymd:2:4}.${date_HM}" #-- 0524.1533
ymd_dHM="${date_ymd:4:2}.${date_HM}" #-- 24.1533

pressEnter=100
cat <<__EOF__

(1) 시작 일련번호: [${pressEnter}]
__EOF__
read begin_no
if [ "x${begin_no}" = "x" ]; then
	begin_no="${pressEnter}"
fi
end_no=$((begin_no + 10))

pressEnter="gemcli"
cat <<__EOF__

(2) AI 이름: [${pressEnter}]
__EOF__
read support_ai
if [ "x${support_ai}" = "x" ]; then
	support_ai="${pressEnter}"
fi

pressEnter="html로 달력만들기"
cat <<__EOF__

(3) 용도 설명: [${pressEnter}]
____.____+____.____+
__EOF__
read use_for
if [ "x${use_for}" = "x" ]; then
	use_for="${pressEnter}"
fi
use_by_underline=$(echo ${use_for} | sed 's/ /_/g')
ai_mdHM="${support_ai}${ymd_mdHM}"

backup_dir="backup-${ai_mdHM}"
mkdir ../${backup_dir}

dir_name="${ai_mdHM}-${use_by_underline}"
mkdir ${dir_name}
cd ${dir_name}
thisdir=$(pwd)

mdirm="../last-${ai_mdHM}-99-${use_by_underline}.md"
mdirmMark="../last-${ai_mdHM}-99-\${use_by_underline}.md"

cat >> ${mdirm} <<__EOF__

cd ${thisdir}; head -10 ${mdirmMark}

#---

msg00="   파일의 내용을 읽고 지시에 따라줘.   "
msg01="   만들어진 txt 를 로컬로 복사.   "
end_no=${end_no}; use_for="${use_for}"
backup_dir=${backup_dir};
begin_no=\$((end_no + 1)); end_no=\$((end_no + 10))
mdirm="${mdirmMark}"
echo "#-- 1"
for (( i=\${begin_no}; i<=\${end_no}; i++ ))
do
echo "#-- 2"
echo "🔥 ${ai_mdHM}-\${i:1}. ( \${use_for} )" >> \${mdirm}
echo "#-- 3"
echo "### 🔥 \${i:1}. " >> \${mdirm}; echo "-----  14, w ${i:1}a-${ai_mdHM}.txt\${msg00}" >> \${mdirm}
echo "#-- 4"

echo "-----  rsync -avzr ../${dir_name}/ ../../${backup_dir}/${i:1}-${dir_name}/\${msg01} >> \${mdirm}
echo "#-- 5"
echo ""; echo "🔋" >> \${mdirm}; echo "### 🔋 ${ai_mdHM}-\${i:1}. " >> \${mdirm}; echo "" >> \${mdirm}
echo "#-- 6"
done

#--- \${use_for}

__EOF__

k=0
for (( i=${begin_no}; i<=${end_no}; i++ ))
do
    cat >> ${mdirm} <<__EOF__
🔥 ${ai_mdHM}-${i:1}. ( ${use_for} )
__EOF__
    if [ $k == 0 ]; then
	    k=1
	    echo "----- 다음줄의 줄 번호를 아래 :14, w ${i:1}a- 부분의 시작번호로 지정하고, 이 줄을 지운다."
    fi
    cat >> ${mdirm} <<__EOF__
### 🔥 ${i:1}. 

-----  14, w ${i:1}a-${ai_mdHM}.txt   파일의 내용을 읽고 지시에 따라줘.   "
-----  rsync -avzr ../${dir_name}/ ../../${backup_dir}/${i:1}-${dir_name}/   만들어진 txt 를 로컬로 복사.   "

🔋
### 🔋 ${ai_mdHM}-${i:1}. 

__EOF__
done

cat <<__EOF__

cd ${thisdir}; head -10 ${mdirm}

__EOF__
