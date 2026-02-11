#!/bin/bash

# 사용법: mytitle <과제명> <시작번호> "<소제목>" [마지막번호]

# 최소 3개의 인수가 필요합니다.
if [ "$#" -lt 3 ]; then
    echo "사용법: mytitle <과제명> <시작번호> \"<소제목>\" [마지막번호]" >&2
    echo "예시: mytitle jobeee 00 \"good day morning\" 12" >&2
    exit 1
fi

JOB_NAME="$1"
START_NUM=$(printf "%d" "$2") # 시작 번호를 정수로 변환
SUBTITLE="$3"

# 소제목의 공백을 밑줄(_)로 변환합니다.
CLEAN_SUBTITLE=$(echo "$SUBTITLE" | tr ' ' '_')

# 마지막 번호를 설정합니다. (입력되지 않으면 시작번호와 동일)
if [ -z "$4" ]; then
    END_NUM=$START_NUM
else
    END_NUM=$(printf "%d" "$4")
fi

# 현재 시각을 포맷에 맞게 설정합니다.
# LC_TIME=C를 사용하여 요일을 영문으로 고정합니다.
DATE_TIME=$(LC_TIME=C date +%m%d_%a.%H%M)

# 시작 번호부터 마지막 번호까지 반복하며 Q/A 쌍을 생성합니다.
for (( i=$START_NUM; i<=$END_NUM; i++ )); do
    # 일련번호를 최소 2자리로 포맷합니다. (예: 00, 01, ..., 99, 100)
    SEQ_NUM=$(printf "%02d" $i)

    # 최종 문자열 포맷
    BASE_STR="${JOB_NAME}.${DATE_TIME}-${SEQ_NUM}.${CLEAN_SUBTITLE}"
    BASE_STR="${JOB_NAME}${wol_il}.${si_bun}-${SEQ_NUM}. ---- 아래 3 의 값을 이 줄의 번호로 바꾸고, 이 줄은 제목으로 다시쓴다.

    # Q/A 쌍 출력
    echo "#--------------- 1 ------ 2 -------- 3 ---------- 4 --------"
    echo "사용법: mytitle <과제명> <시작번호> \"<소제목>\" [마지막번호]" >&2
${JOB_NAME}${wol_il}.${si_bun}-${SEQ_NUM}. ---- 아래 3 의 값을 이 줄의 번호로 바꾸고, 이 줄은 제목으로 다시쓴다.
gemcli1028.1706-01. ---- 아래 3 의 값을 이 줄의 번호로 바꾸고, 이 줄은 제목으로 다시쓴다.
    echo "Q.${BASE_STR}"
    echo "A.${BASE_STR}"
    echo ""
    echo ""
done
