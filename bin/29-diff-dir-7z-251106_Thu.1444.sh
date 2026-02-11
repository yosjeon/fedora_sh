echo ""
for i in 00* 01* 02* 03*; do
    # 1. du 총 크기 추출 및 줄 바꿈 제거 (예: 539M)
    # awk로 첫 번째 필드를 추출한 후, tr로 출력의 줄 바꿈(\n)을 제거합니다.
    SIZE=$(du -ch "${i}"*/ 2>/dev/null | grep total | awk '{print $1}' | tr -d '\n')

    # 2. 디렉토리 이름 추출 및 줄 바꿈 제거 (예: dir00/)
    DIR_NAME=$(ls -d "${i}"*/ 2>/dev/null | tr -d '\n')

    # 3. ls -lh 결과 추출 및 줄 바꿈을 공백 또는 구분자로 대체
    # 'tr'로 내부 줄 바꿈을 공백으로 바꾸고, 'sed'로 마지막에 남을 수 있는 공백을 제거합니다.
    #--X--X-- 필요없음 --X--X-- ARCHIVES=$(ls -lh *-"${i}"-*7z* 2>/dev/null | tr '\n' ' ' | sed 's/ *$//')

    # 4. 세 결과를 한 줄에 정렬하여 출력합니다.
    # %-10s: 왼쪽 정렬로 10칸 확보. %s: 남은 공간 모두 사용.
    #-- printf "%-10s %-15s %s\n" "$SIZE" "$DIR_NAME" #--X--X-- " "$ARCHIVES"
    printf "%s %s\n" "$SIZE" "$(ls -d "${i}"*/ 2>/dev/null | tr -d '\n')" #-- "$DIR_NAME" #--X--X-- " "$ARCHIVES"
    ls -lh *-$i-*7z*[12345] | awk '{print $5" "$9}'
    echo ""
done
