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

backup_dir="../last-${ai_mdHM}"
mkdir ${backup_dir}

dir_name="${ai_mdHM}-${use_by_underline}"
mkdir ${dir_name}
cd ${dir_name}
thisdir=$(pwd)

msg00="   파일의 내용을 읽고 지시에 따라줘.   "
msg01="   만들어진 txt 를 geminicli 가 있는 로컬로 복사하는 스크립트.   "

last_99_md_name="../last-${ai_mdHM}-99-${use_by_underline}.md"

for (( i=${begin_no}; i<=${end_no}; i++ ))
do
    cat >> ${last_99_md_name} <<__EOF__
🔥 ( ${use_for} )
### 🔥 
${ai_mdHM}-${i:1}.

   3,.   w   ${i:1}a-${ai_mdHM}.txt${msg00}   #--
   ----------
rsync -avzr -e 'ssh -p 5822' proenpi@pi:a*/m*/g*/g*.${date_HM}-* ~/Do*/;cd ~/Do*/;ll #--${msg01}

🔋
### 🔋 ${ai_mdHM}-${i:1}.

__EOF__
done

cat <<__EOF__

cd ${thisdir}; tail -39 ${last_99_md_name}

__EOF__

cat >> ${last_99_md_name} <<__EOF__
#---   32dd ${use_for}
#---   cd ${thisdir}; tail -39 ${last_99_md_name}

#--- |||| qna 를 10개 더 만든다.
#--- ||||
#--- vvvv
msg00="${msg00}"
msg01="${msg01}"
end_no=${end_no}; use_for="${use_for}"
backup_dir=${backup_dir};
begin_no=\$((end_no + 1)); end_no=\$((end_no + 10))
last_99_md_name="${last_99_md_name}"
for (( i=\${begin_no}; i<=\${end_no}; i++ ))
do
    cat >> ${last_99_md_name} <<__SRC_EOF__
🔥 ( ${use_for} )
### 🔥 
${ai_mdHM}-\${i:1}.

   3,.   w   \${i:1}a-\${ai_mdHM}.txt\${msg00}   #--
   ----------
rsync -avzr -e 'ssh -p 5822' proenpi@pi:a*/m*/g*/g*.\${date_HM}-* ~/Do*/;cd ~/Do*/;ll #--\${msg01}

🔋
### 🔋 ${ai_mdHM}-\${i:1}.

__SRC_EOF__
done
#--- ^^^^
#--- ||||
#--- |||| qna 를 10개 더 만든다.  🔥 (    ${use_for}    )

__EOF__
