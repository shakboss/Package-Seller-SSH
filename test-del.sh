#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
data=( `cat /etc/passwd | grep home | cut -d ' ' -f 1 | cut -d : -f 1`)
touch kelazz
mulog=$(mesinssh)

#########################
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m               DELETE USER                \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
echo ""
read -p "Username SSH to Delete : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna > /dev/null 2>&1
        userdel -f -r $Pengguna > /dev/null 2>&1
        echo -e "User $Pengguna was removed."
        sleep 1
else
        echo -e "Failure: User $Pengguna Not Exist."
fi

echo -e "$mulog | grep $PID | cut -d ' ' -f 1" >> kelazz
mia=( `cat kelazz`);
for ehh in ${mia[@]}
do
kill $ehh
done
echo "sukses"
rm kelazz
clear