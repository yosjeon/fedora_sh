import webbrowser
import time
import os
import re

def open_software_tabs():
    js_file = '31-app_url_siz_name-data.js'

    if not os.path.exists(js_file):
        print(f"오류: {js_file} 파일을 찾을 수 없습니다.")
        return

    with open(js_file, 'r', encoding='utf-8') as f:
        content = f.read()

    # 개별 객체 { ... } 부분을 묶음으로 추출
    items = re.findall(r'\{(.*?)\}', content, re.DOTALL)

    if not items:
        print("데이터를 찾을 수 없습니다.")
        return

    # [수정 부분] 리스트를 역순으로 뒤집어 마지막 항목부터 열리게 함
    # 이렇게 해야 브라우저 오른쪽 끝부터 왼쪽 순서로 탭이 정렬됩니다.
    items.reverse()

    print(f"총 {len(items)}개의 항목을 역순으로 분석합니다.")

    for item in items:
        # 각 항목 내에서 필요한 필드 추출
        def get_val(key):
            m = re.search(f'{key}:\\s*"(.*?)"', item)
            return m.group(1) if m else ""

        url = get_val('url')
        rem = get_val('rem')
        siz = get_val('siz')
        dat = get_val('dat')
        hed = get_val('hed')
        ver = get_val('ver')
        ext = get_val('ext')

        if url:
            file_name = f"{hed}{ver}{ext}"
            query = f"_siz_{siz}_dat_{dat}_rem_{rem}---{file_name}"
            # URL 파라미터 안전 처리 (공백 등)
            full_url = f"{url}?q={query.replace(' ', '%20')}"

            print(f"열기 중: {file_name}")
            webbrowser.open_new_tab(full_url)
            time.sleep(0.5) # 탭 생성 순서를 보장하기 위한 대기 시간

if __name__ == "__main__":
    open_software_tabs()

