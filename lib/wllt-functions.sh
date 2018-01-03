#!/bin/bash

# functions for wallet-installation

# Install or update from git
git_install() {
cd $HOME
	if [ -d $BASE_NAME ]; then
		cd $BASE_NAME
		git pull
	else
		git clone $GIT
		cd $BASE_NAME
	fi
}

# create desktop file
desktop_create() {
cat << EOF > $COIN_NAME.desktop

[Desktop Entry]
Comment=$DESC_COMMENT
Exec=$EXEC
GenericName[en_US]=$DESC_NAME
GenericName=$DESC_NAME
Icon=
Name[en_US]=$DESC_NAME
Name=$DESC_NAME
Categories=Network;
StartupNotify=false
Terminal=false
Type=Application
MimeType=x-scheme-handler/$COIN_NAME;
EOF

sudo cp $COIN_NAME.desktop /usr/share/applications/
}

# handle blkchn mount-point
blkchn_mnt_create() {
	[ fuser -m $BLK_DIR ] && exit0

	SUB_VOL=`echo BLK_DIR|tr "/" "-"`

	# create subvol
	[ -d $BLKCHN_VOL_MNT/$SUB_VOL ] || {
		sudo btrfs sub create $BLKCHN_VOL_MNT/$SUB_VOL
	}
	# mount-entry for BLKCHN
	[ `grep -q $BLK_DIR /etc/fstab` ] || {
	sudo	printf "LABEL=blkchn\t\t\t$USER_HOME/$BLK_DIR\tbtrfs\t$BTRFS_MNT_OPTS,subvol=$SUB_VOL\t0 0" >> /etc/fstab
	}
}

# mount blkchn sub-vol
blkchn_mount() {
	sudo mount -a
}
