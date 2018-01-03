#!/bin/bash

# installation of Galactrum Coin
# wallet & daemon

GIT=https://github.com/galactrum/galactrum.git
BASE_NAME=`basename $GIT .git`
COIN_NAME=Galactrum
COIN_SIGN=ORE
BLK_DIR=.galactrum/blocks


EXEC=/opt/$BASE_NAME/bin/galactrum-qt
ICON=
DESC_NAME="$COIN_NAME Wallet"
DESC_COMMENT="$COIN_NAME Desktop Wallet"
DESC_KEYWORDS="$COIN_NAME;$COIN_SIGN;Crypto-Currency"
DESC_CATEGORIES=Network


src_compile() {
	./autogen.sh
	./configure --prefix=/opt/$BASE_NAME $CC_FLAGS
	make -j$(nproc)
	sudo make install
}

###################################################################################
#
# adopt values above
#
###################################################################################
SUB_VOL=`echo $BLK_DIR|tr "/" "-"`

source $PRJT_DIR/lib/wllt-functions.sh

# Install from git
git_install

# compile source
src_compile

# create desktop file
desktop_create

# create blkchn mount-point
blkchn_mnt_create

# mount blkchn subvol
blkchn_mount

exit 0
