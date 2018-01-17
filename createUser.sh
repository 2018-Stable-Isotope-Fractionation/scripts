#!/bin/bash

# parameters
username=$1
userpwd=$2
template=$3
group=$4

echo "USAGE: ./createUser.sh username userpwd template group"

if [[ -z $username ]]; then
  echo "ERROR: username required --> createUser.sh username"
  exit 1
fi

if [[ -z $template ]]; then
  echo "ERROR: No template user provided"
fi

echo "Adding user '$username'..."
useradd $username

if [[ -z $group ]]; then
  echo "No group provided, skipping group addition"
else
  echo "Adding user to group $group"
  usermod -a -G $group $username
fi

echo "Setting password"
echo "$username:$userpwd" | chpasswd

echo "Copying R packages from '/home/$template/R'..."
cp -R /home/$template/R /home/$username

echo "Copying R configuration from '/home/$template/.R'..."
cp -R /home/$template/.R /home/$username

echo "Settings permissions for home directory..."
chown -R $username:$username /home/$username

echo "Finished"
