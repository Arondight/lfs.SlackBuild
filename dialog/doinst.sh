#!/usr/bin/env bash

if [[ -r /etc/dialogrc ]]
then
  rm -f /etc/dialogrc.new
else
  mv /etc/dialogrc{.new,}
fi
