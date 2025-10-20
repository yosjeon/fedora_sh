#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | sh
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdYrun () {
        echo "${yyy}#-- ${ccc}$1 ${yyy}#-- 실행하려면, 'y' + Enter: ${bbb}$2${xxx}"
	read a
	if [[ "x$a" == "xy" ]]; then
		echo "$1" | sh
        	echo "${bbb}#// $1 #-- $2${xxx}"
	else
		echo "${bbb}#// ${rrr}$1 ${bbb}#-- 'y' 아니라서 중단합니다.${xxx}"
	fi
}

cat <<__EOF__
${yyy}#-- ${mmm}(0) for 의 파일 이름을 확인해야 합니다.${bbb}

for i in calls-20250727002713.xml.7z calls-20250831071327.xml.7z calls-20250928162458.xml.7z calls-20251005145530.xml.7z calls-20251012071253.xml.7z calls-20251019080550.xml.7z sms-20250727002713.xml.7z sms-20250831071327.xml.7z sms-20250921061440.xml.7z sms-20251005145530.xml.7z

${yyy}#-- ${mmm}press Enter:${xxx}
__EOF__
read a

for i in calls-20250727002713.xml.7z calls-20250831071327.xml.7z calls-20250928162458.xml.7z calls-20251005145530.xml.7z calls-20251012071253.xml.7z calls-20251019080550.xml.7z sms-20250727002713.xml.7z sms-20250831071327.xml.7z sms-20250921061440.xml.7z sms-20251005145530.xml.7z
do
	a=$(echo $i | awk -F"\-" '{print $2}'); y4=${a:0:4}; m2d2=${a:2:4}
	cmdrun "rclone moveto yosjgc:calls_sms/${i} y5ncmi:calls_sms/${y4}/${m2d2}/${i}" "(1) 클라우드로 복사함."
	# cmdrun "rclone copy yosjgc:calls_sms/${i} ." "(1a) 로컬로 복사할때 사용함."
done
cmdrun "rclone lsl yosjgc:calls_sms/ y5ncmi:calls_sms/${y4}/" "(2) 복사 확인."
