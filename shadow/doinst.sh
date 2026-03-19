#!/usr/bin/env bash

pwconv
grpconv

# FIXME this should be part of package
if [[ ! -r /etc/default/useradd ]]
then
  mkdir -p /etc/default
  useradd -D --gid 999
fi
