#!/usr/bin/env bash

ME="$(readlink -f ${0})"
WDIR="$(dirname ${ME})"
RDIR="$(dirname ${WDIR})"
LFS="${LFS:-${RDIR}}"

{
	if [[ 0 -ne "$UID" ]]
	then
		echo "Error: Run as root, quit." >&2
		exit 1
	fi

	mkdir -pv "$LFS"/{dev,proc,sys,run}

	mount -v --bind /dev "${LFS}/dev"
	mount -vt devpts devpts -o gid=5,mode=0620 "${LFS}/dev/pts"
	mount -vt proc proc "${LFS}/proc"
	mount -vt sysfs sysfs "${LFS}/sys"
	mount -vt tmpfs tmpfs "${LFS}/run"

	if [[ -L "${LFS}/dev/shm" ]]; then
		install -vdm 1777 "${LFS}$(realpath /dev/shm)"
	else
		mount -vt tmpfs -o nosuid,nodev tmpfs "${LFS}/dev/shm"
	fi

	chroot "$LFS" /usr/bin/env -i		\
		HOME=/root			\
		TERM="$TERM"			\
		PS1='(lfs chroot) \u:\w\$ '	\
		PATH=/usr/bin:/usr/sbin		\
		MAKEFLAGS="-j$(nproc)"		\
		TESTSUITEFLAGS="-j$(nproc)"	\
		/bin/bash --login
}
