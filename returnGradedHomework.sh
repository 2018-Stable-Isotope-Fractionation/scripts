#!/bin/bash

# parameters
groupname=$1
folderpath=$2
target=$3

echo "USAGE: ./returnGradedHomework.sh groupname folderpath target"

if [[ -z $groupname ]]; then
  echo "ERROR: groupname required --> returnGradedHomework.sh groupname folderpath target"
  exit 1
fi

if [[ -z $folderpath ]]; then
  echo "ERROR: folderpath required --> returnGradedHomework.sh groupname folderpath target"
  exit 1
fi

if [[ -z $target ]]; then
  echo "ERROR: target required --> returnGradedHomework.sh groupname folderpath target"
  exit 1
fi


# find all users
echo "Looking for users in group '$groupname'..."
getent passwd | while IFS=: read name trash
do
    groups $name | cut -f2 -d: | grep -q -w "$groupname" && 
    echo "Copying $folderpath/$name/hw.$name.graded.html to /home/$name/$target" &&
    cp $folderpath/$name/hw.$name.graded.html /home/$name/$target &&
    chown $name:$name /home/$name/$target/hw.$name.graded.html
done

