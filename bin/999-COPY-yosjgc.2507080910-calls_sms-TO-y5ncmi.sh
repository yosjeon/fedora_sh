#!/bin/bash

for i in calls-20250727002713.xml.7z calls-20250831071327.xml.7z calls-20250928162458.xml.7z calls-20251005145530.xml.7z calls-20251012071253.xml.7z calls-20251019080550.xml.7z sms-20250727002713.xml.7z sms-20250831071327.xml.7z sms-20250921061440.xml.7z sms-20251005145530.xml.7z
do
	a=$(echo $i | awk -F"\-" '{print $2}'); y4=${a:0:4}; m2d2=${a:2:4}
	echo "#---- rclone moveto yosjgc:calls_sms/${i} y5ncmi:calls_sms/${y4}/${m2d2}/${i} ---- 클라우드로 복사함."
	rclone moveto yosjgc:calls_sms/${i} y5ncmi:calls_sms/${y4}/${m2d2}/${i}
	echo "#++++ rclone moveto yosjgc:calls_sms/${i} y5ncmi:calls_sms/${y4}/${m2d2}/${i} ++++ 클라우드로 복사함."
	# echo "#---- rclone copy yosjgc:calls_sms/${i} . ---- 로컬로 복사할때 사용함."
	# rclone copy yosjgc:calls_sms/${i} .
	# echo "#++++ rclone copy yosjgc:calls_sms/${i} . ++++ 로컬로 복사할때 사용함."
done
echo "#---- rclone lsl yosjgc:calls_sms/ y5ncmi:calls_sms/${y4}/ ---- 복사 확인."
rclone lsl yosjgc:calls_sms/ y5ncmi:calls_sms/${y4}/
echo "#++++ rclone lsl yosjgc:calls_sms/ y5ncmi:calls_sms/${y4}/ ++++ 복사 확인."
