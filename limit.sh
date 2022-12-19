#!/bin/bash
mulog=$(mesinssh)
#date=$(date)
cekcek=$(echo -e "$mulog" | grep $user | wc -l);
if [[ $cekcek -gt 2 ]]; then
userdel -f -r $user
#nais=3
sleep 0.1
done
