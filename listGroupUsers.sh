#!/bin/bash

# parameters
groupname=$1

if [[ -z $groupname ]]; then
  echo "ERROR: groupname required --> listGroupUsers.sh groupname"
  exit 1
fi

# find all users
echo "Looking for users in group '$groupname'..."
getent passwd | while IFS=: read name trash
do
    groups $name | cut -f2 -d: | grep -q -w "$groupname" && echo "User '$name'"
done
