#!/bin/bash

# parameters
groupname=$1
minutes=$2

if [[ -z $groupname ]]; then
  echo "ERROR: groupname required --> cleanupDataHistory.sh groupname minutes"
  exit 1
fi

if [[ -z $minutes ]]; then
  minutes="1440"
  echo "No time frame provided for deleting old plots, defaulting to $minutes minutes (=1 day)."
fi

# find all users
echo "Looking for users in group '$groupname'..."
getent passwd | while IFS=: read name trash
do
    groups $name | cut -f2 -d: | grep -q -w "$groupname" && 
    printf "Searching /home/$name/ for old .RData files: " &&
    find /home/$name/ -wholename "*/.RData" -type f -mmin +$minutes | wc -l &&
    printf "Deleting /home/$name/ old .RData files..." &&
    find /home/$name/ -wholename "*/.RData" -type f -mmin +$minutes -delete &&
    echo " done."
done



