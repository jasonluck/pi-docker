#!/bin/bash

SHARED_FOLDER="/shared"

# Install Samba
sudo apt update
sudo apt install -y samba samba-common-bin

# Setup shared folder
sudo mkdir $SHARED_FOLDER
sudo chmod 777 $SHARED_FOLDER

# Add folder to Samba configuration
cat <<EOF | sudo tee -a /etc/samba/smb.conf
[shared]
path=$SHARED_FOLDER
writeable=Yes
create mask=0777
directory mask=0777
public=no
EOF

# Restart Samba Service
sudo systemctl restart smbd

# Create user account for connecting to shared drive
sudo adduser nas-user
echo "Enter a password for the 'nas-user' account"
sudo smbpasswd -a nas-user

echo "You can now connect to the fileserver at smb://$HOSTNAME using the account name 'nas-user' and the password you just provided."

