#1/bin/sh

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

enter_d_or_s="$1"
show_D=" ..... 다운로드 받은 파일목록 작성"
show_S=" ..... 백업해둔 파일목록 작성"
cat <<__EOF__
D ${show_D}
S ${show_S}
#---> Enter: [ ${enter_d_or_s} ] #-- D 또는 S
__EOF__
read a

if [ "x$a" != "x" ]; then
	enter_d_or_s=$a
fi
if [[ "x${enter_d_or_s}" == "xD" ]]; then
	show_D_or_S="${show_D}"
else
	if [[ "x${enter_d_or_s}" == "xS" ]]; then
		show_D_or_S="${show_S}"
	else
		echo "#-- 첫번째 전달자에 D 또는 S 값이 있어야 합니다."
		exit -103
	fi
fi

enter_zero_or_one_two="$2"
show_0=" ..... 00-bada 의 목록"
show_1=" ..... 01-last_big_files 의 목록"
show_2=" ..... 02-more_300M_files 의 목록"
show_3=" ..... 03-big_files 의 목록"
echo "${uuu}"
cat <<__EOF__
${rrr}[ ${yyy}${enter_d_or_s} ${rrr}]${bbb}${show_D_or_S}${xxx}

0 ${show_0}
1 ${show_1}
2 ${show_2}
3 ${show_3}
#---> Enter: [ ${enter_zero_or_one_two} ] #-- 0, 1, 2 또는 3
__EOF__
read a

if [ "x$a" != "x" ]; then
	enter_zero_or_one_two=$a
fi
if [[ "x${enter_zero_or_one_two}" == "x0" ]]; then
	show_0_1_2_3="${show_0}"
	dir_00010203="00"
	dirName="${dir_00010203}-bada"
	abc_is="0a"
	abc_ds_dirName="${abc_is}${enter_d_or_s}-${dirName}" #-- 0a{DS}-00-bada
else
	if [ "x${enter_zero_or_one_two}" == "x1" ]; then
		show_0_1_2_3="${show_1}"
		dir_00010203="01"
		dirName="${dir_00010203}-last_big_files"
		abc_is="0b"
		abc_ds_dirName="${abc_is}${enter_d_or_s}-${dirName}" #-- 0b{DS}-01-last_
	else
		if [ "x${enter_zero_or_one_two}" == "x2" ]; then
			show_0_1_2_3="${show_2}"
			dir_00010203="02"
			dirName="${dir_00010203}-more_300M_files"
			abc_is="0c"
			abc_ds_dirName="${abc_is}${enter_d_or_s}-${dirName}" #-- 0c{DS}-02-more_
		else
			if [ "x${enter_zero_or_one_two}" == "x3" ]; then
				show_0_1_2_3="${show_3}"
				dir_00010203="03"
				dirName="${dir_00010203}-big_files"
				abc_is="0d"
				abc_ds_dirName="${abc_is}${enter_d_or_s}-${dirName}" #-- 0d{DS}-03-big_
			else
				echo "#-- 두번째 전달자에 0, 1, 2 또는 3 값이 있어야 합니다."
				exit -104
			fi
		fi
	fi
fi
echo "${uuu}"
cat <<__EOF__
${rrr}[ ${yyy}${enter_zero_or_one_two} ${rrr}]${bbb}${show_0_1_2_3}${xxx}

__EOF__

trash_dir="trash-dir"
if [[ ! -d ${trash_dir} ]]; then
	cmdrun "mkdir ${trash_dir}" "(0) 지난번 파일들을 옮겨둘 폴더를 만듭니다."
fi

cmdrun "ls -l *${abc_ds_dirName}*[z123lt]; mv *${abc_ds_dirName}*[z123lt] ${trash_dir}/" "(1) 지난번 파일들을 ${trash_dir} 폴더로 옮깁니다."

seq_dir_ymdHM_7z="${abc_ds_dirName}-$(LC_TIME=C date +%y%m%d_%a.%H%M).7z"

#-- 이름순
#-- 제외함 cmdrun "ls -l ${dirName}/ | awk -v dors="${enter_d_or_s}" 'NR > 1 { file_type = substr(\$1, 1, 1); printf \"%s %s %12s %5s %2s %5s %s \", file_type, dors, \$5, \$6, \$7, \$8, \$9; printf \"\\n\" }' > ${seq_dir_ymdHM_7z}.ls-l" "(2) 이름순 ${seq_dir_ymdHM_7z}.ls-l 목록을 만듭니다."

#-- 기타 = 시간순
i="0${enter_zero_or_one_two}"
cmdrun "ls -lrt ${dirName}/ | awk -v dors="${enter_d_or_s}" 'NR > 1 { file_type = substr(\$1, 1, 1); printf \"%s %s %12s %5s %2s %5s %s \", file_type, dors, \$5, \$6, \$7, \$8, \$9\" \"\$10\" \"\$11\" \"\$12\" \"\$13\" \"\$14; printf \"\\n\" }' > ${seq_dir_ymdHM_7z}.ls-lrt; ls -ltr $i*|tail -6|awk -F\"i proenpi\" '{print \$2}'; tail -6 0?S-$i-*t" "(3) ${seq_dir_ymdHM_7z}.ls-lrt 시간순 목록을 만듭니다." #-- 0[abc][DS]-0[012]-

cmdYrun "time 7za a -mx=9 -v4092m -p ${seq_dir_ymdHM_7z} ${dirName}/" "(4) ${dirName} 폴더를 ${seq_dir_ymdHM_7z} 파일로 압축합니다."

cmdrun "ls -l ${trash_dir}/" "(5) 정리후 삭제할 지난번 파일들 입니다."
local_lrt="local-$(LC_TIME=C date +%y%m%d_%a.%H%M).lrt"
cmdrun "rm -f local-*lrt; ls -lrt > ${local_lrt}; tail -9 ${seq_dir_ymdHM_7z}*t; echo \"---\"; tail -9 ${local_lrt}; echo \":::\"; ls -ltr $i*|tail -9|awk -F\"i proenpi\" '{print \$2}'" "(6) 다운로드 완료후 파일을 비교합니다."
