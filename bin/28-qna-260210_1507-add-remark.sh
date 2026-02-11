#!/bin/bash

echo "#-- 28-qna-251227_Sat.1039-line11to10.sh"
a="gemini"
echo "#-- (1) ai 이름 [ ${a} ]"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
ai_is="$b"
a="0"
echo "#-- (2) 시작 일련번호 [ ${a} ]"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
bg_no="$b"
a=$(( $b + 10 ))
echo "#-- (3) 끝 일련번호 [ ${a} ]"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
nd_no="$b"
if [ "x$1" == "x" ]; then
    a="토론의 주제를 입력합니다"
else
    a="$1"
fi
echo "#-- (4) 토론의 주제 입력 또는, press Enter: [ ${a} ]"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
ju_je="$b"
ymdHM=$(LC_TIME=C date +%Y%m%d%H%M)
#-- echo "#-- ymdHM ${ymdHM}"
#-- echo "#-- ymdHM YYYYmmddHHMM;"
y4md=${ymdHM:0:8}
#-- echo "#-- y4md ${y4md}"
#-- echo "#-- y4md YYYYmmdd;"
h2m2=${ymdHM:8:4}
#-- echo "#-- h2m2 ${h2m2}"
#-- echo "#-- h2m2 HHMM;"
a=${y4md}
echo "#-- (5) 등록하는 년도4자리+월일 [ ${a} ] 8 자리"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
y4md="$b"
a=${h2m2}
echo "#-- (6) 등록하는 시분 [ ${a} ] 4 자리"
read b
if [ "x$b" == "x" ]; then
    b="$a"
fi
a="n"
echo "#-- (7) mkdir + rsync 명령 추가 = 'y', 아니면 = '$a', press Enter 면 추가 안함= [ $a ]"
read mr_y
if [ "x$mr_y" == "x" ]; then
    mr_y="$a" #-- Enter = n
fi
echo "mr_y == $mr_y"
echo ""
h2m2="$b"
d2h2=${ymdHM:6:2}${h2m2:0:2}
u_juje=$(echo "${ju_je}" | tr ' ' '_')
aiy4="${ai_is}${y4md:0:4}"
aimdHM=${ai_is}${y4md:2:6}.${h2m2}
linux_dir="archive/myusb/${aiy4}/${aimdHM}-${u_juje}"
mkdir -p ~/${linux_dir}
cd ~/${linux_dir}/../
windows_dir="~/Downloads/${aiy4}/${aimdHM}-${u_juje}"
last_md="last-${aimdHM}-${u_juje}.md"
echo "" > ${last_md}
echo "\`\`\`" >> ${last_md}
echo "-- Title -----" >> ${last_md}
echo "${y4md:6:2}.${h2m2:0:2} ${ju_je}" >> ${last_md}
echo "" >> ${last_md}
echo "-- Path -----" >> ${last_md}
echo "${ai_is}/${y4md:0:4}/${y4md:2:4}/${y4md:2:6}_${h2m2}" >> ${last_md}
echo "\`\`\`" >> ${last_md}
line1="o"
for i in $(seq ${bg_no} ${nd_no}); do
    #-- $h2m2 $i 등의 값을 지정형식 "%s_%02d" 로 만들어 -v 변수에 담는다.
    printf -v zz_i "%s_%02d" $d2h2 $i
    echo ""
    echo "🔥 🔥"
    if [ "x$i" == "x$bg_no" ]; then
        echo "# ${zz_i}, " #-- 첫번째를 최고제목으로 표시한다.
    else
        echo "## ${zz_i}, "
    fi
    echo ""
    echo "11,. w   ${zz_i}q-${aimdHM}.md   를 읽고, 한글로 ${zz_i}r-${aimdHM}.md 파일에 답을 써줘."
    if [ "x${line1}" == "xo" ]; then #-->> 첫번째 줄에만 표시함.
        line1="x"
        echo ""
        echo "\`\`\`"
        echo "받은 대답 중에서 '가이드에 맞춰 ** 단계별 가이드 ** 를 정리해' 라는 문장은 별표가 그대로 들어나 보여. 그래서 이걸 '가이드에 맞춰 **단계별 가이드** 를 정리해' 라고 고쳤더니, '단계별 가이드' 부분이 굵은 글씨체로 변하더라고. 그러니,"
	echo "예를 들면 '이부분이 **강조** 를 하는거야' 와 같이, 강조할 문장 앞뒤에 강조문장의 표시인 별표 2개를 공백없이 붙인뒤 '**강조**' 의 앞뒤에 공백을 둬서 ' **강조** ' 처럼 만들어야 해. 이 wiki.js 규칙을 지켜줘."
        echo ""
        echo "그리고, wiki.js 의 제목표시는, 내가 '#' 와 '##' 를 쓰고 있으니, '###' 부터 시작해줘. 그리고 이런 제목에는 별표로 강조하지마. 이건 강조가 안되고, 그냥 별표가 나타나더라구."
        if [ "x${mr_y}" == "xy" ]; then
            echo ""
            echo "mkdir -p ${windows_dir} && cd ${windows_dir} #-- windows에 쓸경우만, 질답파일 보관 폴더 만들기"
            echo ""
            echo "rsync -avzr -e 'ssh -p 5822' proenpi@pi:${linux_dir}/${zz_i}q-*.md .; ll #-- 만들어진 md 를 geminicli 가 있는 windows 로컬로 복사하는 스크립트."
	fi
        echo "\`\`\`"
    fi #--<< 첫번째 줄에만 표시함.
    echo ""
    echo "🔋 🔋 ( ${ju_je} ${aimdHM} )"
    echo "### ${zz_i}' "
    echo ""
done >> ${last_md}
echo ""
vi ${last_md}
cat ${last_md}
echo "#-- cat ${last_md}"
echo "# --o----1----o----2----o----3----o----4----o----5----o----6----X---"
