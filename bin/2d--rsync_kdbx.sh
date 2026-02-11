#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
cmdend () {
        echo "${rrr}#--///-- ${mmm}$1${xxx}"
}
pswdonly () { #-- "(1) INPUT: port #"  "(입력시 표시 안됨)"
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"
        read -s pswdonly
	echo " "
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
readecho () { #-- "(2) INPUT: 서버 디렉토리"  "${svrDIR}"
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"
        read readecho
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}

echo "#----> (1) -p nn22:"
read a
svrPORT="${a}22"
echo "#----> (2) nnpiAt:"
read b
userID="${b}pi"
svrURL="pi"
svrDIR="ar*/ke*"
keepsNameExt="ke*bx"
echo "#-- rsync -avzr -e 'ssh -p ${svrPORT}' ${userID}@${svrURL}:${svrDIR}/${keepsNameExt} ."
rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:${svrDIR}/${keepsNameExt} .
