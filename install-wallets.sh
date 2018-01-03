#!/bin/bash

# Install wallets from git

#Default Variables

# blank separated list of supported Coins
ALL_WALLETS_DEF="ORE ALTCOM XVG"

# BLK-CHN mounts
BLKCHN_VOL_MNT_DEF=/mnt/.btrfs/blkchn
BTRFS_MNT_OPTS_DEF="defaults,noatime,compress=lzo,autodefrag"
USER_UID_DEF=1000
USER_HOME_DEF=`grep $USER_UID_DEF /etc/passwd|cut -d: -f6`
CC_FLAGS_DEF="--enable-upnp-default --enable-silent-rules --enable-qrencode" 
P_HOME_DEF="$HOME/trustOne"

DEBIAN_FRONTEND=noninteractive
PREPARED_MARKER=$HOME/.install-wallets_prepared

[ -r $PRCT_DIR/install-wallets.conf ] && {
	source $PRCT_DIR/install-wallets.conf
}

export ALL_WALLETS=${ALL_WALLETS:=$ALL_WALLETS_DEF}
export BLKCHN_VOL_MNT=${BLKCHN_VOL_MNT:=$BLKCHN_VOL_MNT_DEF}
export BTRFS_MNT_OPTS=${BTRFS_MNT_OPTS:=$BTRFS_MNT_OPTS_DEF}
export USER_HOME=${USER_HOME:=$USER_HOME_DEF}
export CC_FLAGS=${CC_FLAGS:=$CC_FLAGS_DEF}
export P_HOME=${P_HOME:=$P_HOME_DEF}


echo ALL_WALLETS     $ALL_WALLETS   
echo BLKCHN_VOL_MNT  $BLKCHN_VOL_MNT
echo BTRFS_MNT_OPTS  $BTRFS_MNT_OPTS
echo USER_HOME       $USER_HOME
echo CC_FLAGS        $CC_FLAGS
echo P_HOME          $P_HOME






# prepare system
prepare_system() {
	sudo add-apt-repository -y ppa:bitcoin/bitcoin
	sudo \apt-get update
	sudo \apt-get install -y --force-yes $(cat $P_HOME/wllt-dependencies.lst $P_HOME/lib/wllt-dependencies.lst|xargs)

	touch $PREPARED_MARKER
}

usage() {
echo
echo "$0 [options]…"
echo "Installes various Crypto-Wallets"
echo
echo "Supported wallets: $ALL_WALLETS"
echo "Options:"
echo "   -a|--all    Installes/updates all supported Wallets for CryptoCurrency"
echo "   <SIGN>      Installes/updates the Wallet for CryptoCurrency with the Sign <SIGN>"
echo
}

# if the dependencies file was updated since last run, go, get the system prepared again
[ $PREPARED_MARKER -ot $P_HOME/wllt-dependencies.lst ] && PREP_FLAG=true
[ $PREPARED_MARKER -ot $P_HOME/lib/wllt-dependencies.lst ] && PREP_FLAG=true
[ $PREP_FLAG ] && prepapre_system




#############################
#   main menue
#############################

for i in $*; do
	case $i in
		ORE)
			lib/install-ore.sh
			shift
			;;
		XVG)
			lib/install-xvg.sh
			shift
			;;
		altcom)
			lib/install-altcom.sh
			shift
			;;
		-a|--all)
			exec ./$0 $ALL_WALLETS
			exit 0
			;;
		-h|--help)
			usage
			exit 0
			;;
	esac
done

exit 0
