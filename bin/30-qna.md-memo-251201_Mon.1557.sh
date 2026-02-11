

ai_name="gemini";
start_no=0;
if [ "x$1" != "x" ];
then start_no=$1;
else echo "#-- $0 ${ai_name}용으로 지정함: [0부터 시작하는 일련번호] [작업 설명]"; exit -1;
fi;
shift; whatis="$@";
if [ "x$whatis" = "x" ];
then echo "#-- 작업 설명 입력";
read whatis;
fi;
whatisstring=$(echo "${whatis}" | sed 's/ /_/g')
ymd_HM=$(LC_TIME=C date +%y%m%d%H%M);
ymd=${ymd_HM:0:6}; h2m2=${ymd_HM:6:4}
ai_ymd_HM=${ai_name}.${ymd}.${h2m2};
q_md=${ai_ymd_HM}-${whatisstring}.md
stop_no=$(( start_no + 9 ));
for i in $(seq ${start_no} ${stop_no});
do printf -v zero_i "%02d" $i;
echo "";
echo "# 🔥 ${h2m2}-${zero_i}q.";
echo "2,. w ${zero_i}q-${ai_ymd_HM}.md 를 읽고, 한글로 ${zero_i}r-${ai_ymd_HM}.md 에 답을 써줘.";
echo "";
echo "🔥 ( ${ai_ymd_HM} ${whatis} )";
echo "## 🔋 ${h2m2}-${zero_i}r."; done > last-${ai_ymd_HM}-${whatisstring}.md;
mkdir ${ai_ymd_HM}-${whatisstring};
echo "";
echo "cd ${ai_ymd_HM}-${whatisstring}; vi ../last-${ai_ymd_HM}-*";
echo ""
