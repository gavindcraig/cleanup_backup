#!/usr/bin/env bash

# A SCRIPT TO DELETE OLDER FILES WHILE KEEPING SOME
# BY GAVIN D. CRAIG

#     ______  ______      ______  
#   .' ___  ||_   _ `.  .' ___  | 
#  / .'   \_|  | | `. \/ .'   \_| 
#  | |   ____  | |  | || |        
#  \ `.___]  |_| |_.' /\ `.___.'\ 
#   `._____.'|______.'  `.____ .' 

dir="${HOME}/backup/mysql/"
all_files=$(/bin/ls $dir*.sql)

# FORMATTED DATE BEFORE WHICH TO DELETE FILES
rem_date=$(date --date='-3 month' '+%Y-%m-')
fprefix="organ_scores-"

# ADD FILES TO BE DELETED TO NEW ARRAY
delete_these=()

for file in $all_files
do
if [[ " ${delete_these[@]} " =~ " $file " ]]; then
    continue
elif [[ $file < $dir$fprefix$rem_date ]]; then
    pattern="${file: -14:7}"
        for each in $all_files; do
            [[ $each != $file ]] && [[ ! " ${delete_these[@]} " =~ " $each " ]] && [[ $each =~ .+$pattern.+ ]] && delete_these+=( "$each" )
        done
    continue
fi
done

for file in "${delete_these[@]}"
do
    rm -f $file
done
