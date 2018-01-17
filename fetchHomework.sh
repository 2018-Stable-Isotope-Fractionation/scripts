#!/bin/bash

# parameters
groupname=$1
folderpath=$2
target=$3

# example
# sudo ./fetchHomework.sh SIF2016 SIF2016/homework02 /home/shk/SIF2016/homework02_completed_1103

echo "USAGE: ./fetchHomework.sh groupname folderpath target"

if [[ -z $groupname ]]; then
  echo "ERROR: groupname required --> fetchHomework.sh groupname folderpath target"
  exit 1
fi

if [[ -z $folderpath ]]; then
  echo "ERROR: folderpath required --> fetchHomework.sh groupname folderpath target"
  exit 1
fi

if [[ -z $target ]]; then
  echo "ERROR: target required --> fetchHomework.sh groupname folderpath target"
  exit 1
fi


# find all users
echo "Looking for users in group '$groupname'..."
getent passwd | while IFS=: read name trash
do
    groups $name | cut -f2 -d: | grep -q -w "$groupname" && 
    echo "Copying /home/$name/$folderpath to $target/$name" &&
    rm -f -R $target/$name &&
    cp -R /home/$name/$folderpath $target/$name
done

