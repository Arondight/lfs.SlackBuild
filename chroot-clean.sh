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

  if mountpoint -q "${LFS}/run/"
  then
    umount -v "${LFS}/run/"
  fi

  if mountpoint -q "${LFS}/sys/"
  then
    umount -v "${LFS}/sys/"
  fi

  if mountpoint -q "${LFS}/proc/"
  then
    umount -v "${LFS}/proc/"
  fi

  if mountpoint -q "${LFS}/dev/shm/"
  then
    umount -v "${LFS}/dev/shm/"
  fi

  if mountpoint -q "${LFS}/dev/pts/"
  then
    umount -v "${LFS}/dev/pts/"
  fi

  if mountpoint -q "${LFS}/dev/"
  then
    umount -v "${LFS}/dev/"
  fi
}
