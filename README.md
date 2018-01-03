# trustOne – a Universal cryptoready VM-template

## Abstract
* luks-encrypted FS
* default pw's
* run-once-shell on first boot to initialize
* customization-script to adapt usernames, passwords, etc.
* setup of the usual dev-enironment
* 2nd-HDD for blockchains
* Supports various CryptoWallets (git-repro-connection)  


## Short
After boot and the following run_once-initalisation, login with the user ```cryptomaster``` and run the customization script.
```
crypto-vm/lib/customize.sh
```
## Install CryptoWallets  
```
crypto-vm/install-wallets.sh --all|[CUR] [CUR]
```

## Passwords
Default-pw's with leet = l33t. see [leet](https://simple.wikipedia.org/wiki/Leet)
Only letter to single numbers are used.

HDD-encryption Passphrase (cryptomaster =): <ryp70m4573r

Default User: cryptomaster
PW (cryptomaster =): <ryp70m4573r

## Step by Step
* Download the prepared images or create by yourself (see below)
* copy the images (to keep the templates untouched)
* Create a new VM with the copied images
* Boot up the VM
* Let the run-once Initalisation happen
* Login after reboot as user ```cryptomaster```
* call the customization Script

```
crypto-vm/lib/customize.sh --help
customize.sh: [options] ...

Customize your template of crypto-vm (basicaly needs to be a Ubuntu 16.04 LTS, with encrypted FS)
 * set new hostname
 * add a new default-User
 * changes Passphrase for HDD-encryption
 * install needed SW
 * upgrades System

Options:
  -h,--help                     show this message
  -m,--masterpw <PASSWORD>      give new password for user cryptomaster
  -n,--hostname <HOSTNAME>      set new hostname
  -p,--password <PASSWORD>      give new Password for default user (see -u)
  -r,--enable-root <PASSWORD>   enable root login and give new password
  -u,--user <USERNAME>          create new default user (see -p)

If no options are given, all needed parameters will be asked for
```


## Create the Images by yourself
Basicly, the first image is a Ubuntu-Server 16.04 LTS with an encrypted Partition.
The second image is a unencrypted big storage for the varius Blockchains, formated with BTRFS.
It has to be mounted under ```/mnt/.btrfs/blkchn```

Create a master-user (not your default user, i.e. you) and get the repo.
```
git clone https://github.com/chymian/crypto-vm
```

Then run the two scripts to initialze and customize the images:

```
sudo crypto-vm/lib/run-once-stub.sh
sudo crypto-vm/lib/customize.sh
```
