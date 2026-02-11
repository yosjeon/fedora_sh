#!/bin/bash

# 사용법: mytitle <과제명> "<소제목>" [시작번호] [끝번호]

if [ "$#" -lt 2 ]; then
    echo "#-- 최소한 2개의 인수가 필요합니다."
    echo "사용법: bash $0 <과제명> \"<소제목>\" [시작번호] [끝번호]" >&2
    echo "sh 가 아니고 bash 로 실행해야 합니다."
    echo "예시: $0 jobeee 00 \"good day morning\" 12" >&2
    exit 1
fi

# sh 44-for-bash-build-gemini-251108_Sat.1426.sh gemcli "qna 를 기록하는 메모장 작성" 00
#----------------------------------------------- $1 ---- $2 ------------------------- $3

AI_BRAND="$1" #-- gemcli
JEMOK="$2" #-- "qna 를 기록하는 메모장 작성"
UNDERLINE_JEMOK=$(echo "$JEMOK" | tr ' ' '_') # 소제목의 공백을 밑줄(_)로 변환합니다.

# 시작 번호를 설정합니다. (입력되지 않으면 "00" 으로 지정)
if [ "x$3" = "x" ]; then #-- 00
        FIRST_NUM=$(printf "%d" "00") # 시작 번호를 정수로 변환
else
        FIRST_NUM=$(printf "%d" "$3") # 시작 번호를 정수로 변환
fi
# 끝 번호를 설정합니다. (입력되지 않으면 시작번호와 동일)
if [ "x$4" = "x" ]; then
        LAST_NUM=$(( $FIRST_NUM + 9 )) #-- 
else
        LAST_NUM=$4
fi

# LC_TIME=C를 사용하여 요일을 알파벳으로 고정합니다.
JOB_Y4="${AI_BRAND}$(date +%Y)" #-- gemcli2025
DATE_md_HM=$(LC_TIME=C date +%m%d.%H%M) #-- 1026.1734 # DATE_TIME=$(LC_TIME=C date +%m%d_%a.%H%M)
JOB_CODE="${AI_BRAND}${DATE_md_HM}" #-- gemcli1026.1734

#-- WINDOWS_JOBCODE="${HOME}/Downloads/${JOB_Y4}/${JOB_CODE}" #-- ~/Downloads/gemcli2025/gemcli1026.1734
WINDOWS_JOBCODE="${JOB_Y4}/${JOB_CODE}" #-- gemcli2025/gemcli1026.1734
WINDOWS_DIR="${WINDOWS_JOBCODE}-${UNDERLINE_JEMOK}" #-- ((~/Downloads/gemcli2025/gemcli1026.1734))-windows용_pomodoro앱_만들기

LAST_99_MD_NAME="last-${JOB_CODE}-99-${UNDERLINE_JEMOK}.md" #-- last-gemcli1026.1734-99-windows용_pomodoro앱_만들기.md

first_in_loops="o"

mkdir -p ${WINDOWS_DIR}
cd ${WINDOWS_DIR}

# 시작 번호부터 끝 번호까지 반복하며 Q/A 쌍을 생성합니다.
for (( i=$FIRST_NUM; i<$LAST_NUM+1; i++ )) #-- line 31: $추가
do
    # 일련번호를 최소 2자리로 포맷합니다. (예: 00, 01, ..., 99)
    SEQ_NUM=$(printf "%02d" $i) #-- 00

    # 최종 문자열 포맷
    JOB_DATE_SEQ="${JOB_CODE}-${SEQ_NUM}" #-- gemcli1026.1734 - 00

    # Q/A 쌍 출력
    cat >> ../${LAST_99_MD_NAME} <<__EOF__
🔥 ( ${UNDERLINE_JEMOK} )
### 🔥
${JOB_DATE_SEQ}a. --<== 이 줄의 번호로 아래 3,. 값을 바꾸고, 이곳은 제목으로 다시쓴다.

__EOF__
#--
    if [ "x${first_in_loops}" == "xo" ]; then
        first_in_loops="x" #-- 처음에만 다음을 출력하려는 것임.
        cat >> ../${LAST_99_MD_NAME} <<__EOF__
한국어로 물어도 영어로 답변이 나오면 불편하니, 소스가 아닌 답변은 모두 한국어로 해줘.

3,. w ${SEQ_NUM}a-${JOB_CODE}.txt   파일의 내용을 진행한 결과를 ${SEQ_NUM}b-${JOB_CODE}.txt 파일에 저장해줘.
   ----------
mkdir -p ${WINDOWS_DIR}; cd ${WINDOWS_JOBCODE}*
rsync -avzr -e 'ssh -p 5822' proenpi@pi:a*/m*/g*/${SEQ_NUM}a-*.txt ${WINDOWS_JOBCODE}*/; ll #--   만들어진 txt 를 geminicli 가 있는 windows 로컬로 복사하는 스크립트.
__EOF__
        #-- mkdir -p ${WINDOWS_DIR} #-- (( ~/Downloads/gemcli2025/gemcli1026.1734 ))-windows용_pomodoro앱_만들기
        #-- cd ${WINDOWS_JOBCODE}* #-- (( gemcli2025/gemcli1026.1734 ))
    else
        cat >> ../${LAST_99_MD_NAME} <<__EOF__
3,. w ${SEQ_NUM}a-${JOB_CODE}.txt   파일의 내용을 진행한 결과를 ${SEQ_NUM}b-${JOB_CODE}.txt 파일에 저장해줘.
   ----------
rsync -avzr -e 'ssh -p 5822' proenpi@pi:a*/m*/g*/${SEQ_NUM}a-*.txt ${WINDOWS_JOBCODE}*/; ll #--   만들어진 txt 를 geminicli 가 있는 windows 로컬로 복사하는 스크립트.
__EOF__
    fi
    cat >> ../${LAST_99_MD_NAME} <<__EOF__

🔋
### 🔋 ${JOB_DATE_SEQ}b.



__EOF__
done
echo "#-- 작성한 ../${LAST_99_MD_NAME} 파일 확인."
cat ../${LAST_99_MD_NAME}
echo "#// 작성한 ../${LAST_99_MD_NAME} 파일 확인."
echo "#--"
echo "#-- 작업할 곳:  cd ${WINDOWS_JOBCODE}* ; vi ../last*99*md"
