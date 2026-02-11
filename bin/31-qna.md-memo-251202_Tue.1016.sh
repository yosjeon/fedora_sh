#!/bin/sh

ai_name="gemini";
a="0";
echo "#-- (1) 시작 일련번호 [ ${a} ]";
read b;
if [ "x$b" = "x" ];
  then b="$a";
fi;
start_no="$b";
stop_no=$(( start_no + 9 ));
a="토론의 주제를 입력합니다";
echo "#-- {2} 작업 설명 [ ${a} ] ";
read b;
if [ "x$b" = "x" ];
  then b="$a";
fi;
job_is="$b";
u_jobis=$(echo "${job_is}" | tr ' ' '_');
ymdHM=$(LC_TIME=C date +%y%m%d%H%M);
y2md=${ymdHM:0:6};
h2m2=${ymdHM:6:4};
aiy4="${ai_name}20${y2md:0:2}"; #-- gemcli2025
ai_mdHM=${ai_name}${y2md:2}.${h2m2}; #-- gemcli1202.0917
windows_ujobis="~/Downloads/${aiy4}/${ai_mdHM}-${u_jobis}"; #-- ~/Downloads/gemcli2025/gemcli1202.0917-windows용_pomodoro앱_만들기
md_name="last-${ai_mdHM}-${u_jobis}.md";
echo "-- Title -----" > ${md_name};
echo "${y2md:4:2}_${h2m2:0:2} ${job_is}" >> ${md_name};
echo "" >> ${md_name};
echo "-- Path -----" >> ${md_name};
echo "${ai_name}/20${y2md:0:2}/${y2md:0:4}/${y2md}_${h2m2}" >> ${md_name};
echo "" >> ${md_name};
first_loop="o";
for i in $(seq ${start_no} ${stop_no});
do printf -v zero_i "%02d" $i;
  echo "";
  echo "# 🔥 ${zero_i}q.";
  echo "";
  echo "3,. w ${zero_i}q-${ai_mdHM}.md 를 읽고, 한글로 ${zero_i}r-${ai_mdHM}.md 에 답을 써줘.";
  echo "";
  if [ "x${first_loop}" == "xo" ]; then first_loop="x";
    echo "mkdir -p ${windows_ujobis}; cd ${windows_ujobis}";
  fi;
  echo "rsync -avzr -e 'ssh -p 5822' proenpi@pi:a*/m*/${aiy4}/${ai_mdHM}-*/${zero_i}q-*.txt .; ll #--   만들어진 txt 를 geminicli 가 있는 windows 로컬로 복사하는 스크립트.";
  echo "";
  echo "🔥 ( ${ai_mdHM} ${job_is} )";
  echo "## 🔋 ${zero_i}r.";
done > ${md_name};
mkdir ${ai_mdHM}-${u_jobis};
echo "";
echo "#-- ls ${ai_mdHM}-${u_jobis}";
ls ${ai_mdHM}-${u_jobis};
ll=$(ls -l | tail -1 | awk '{print $3" "$4}');
ls -l | awk -F"$ll" '{print $2}';
echo "";
echo "#-- cd ${ai_mdHM}-${u_jobis}; vi ../${md_name};";
echo "#-- press Enter:"; read a;
cd ${ai_mdHM}-${u_jobis}; vi ../${md_name};
echo ""
