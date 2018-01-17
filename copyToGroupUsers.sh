#!/bin/bash

# parameters
groupname=$1
filepath=$2
subfolder=$3

echo "USAGE: ./copyToGroupUsers.sh groupname filepath subfolder"

if [[ -z $groupname ]]; then
  echo "ERROR: groupname required --> copyToGroupUsers.sh groupname filepath"
  exit 1
fi

if [[ -z $filepath ]]; then
  echo "ERROR: filepath required --> copyToGroupUsers.sh groupname filepath"
  exit 1
fi


# find all users
filename="${filepath##*/}"
echo "Preparing to copy $filename from $filepath"
echo "Looking for users in group '$groupname'..."
getent passwd | while IFS=: read name trash
do
    groups $name | cut -f2 -d: | grep -q -w "$groupname" && 
    echo "Copying $filepath to /home/$name/$subfolder" &&
    cp -R $filepath /home/$name/$subfolder &&
    chown -R $name:$name /home/$name/$subfolder &&
    chown -R $name:$name /home/$name/$subfolder/$filename
done

