#!/usr/bin/env bash

pushd /usr/share/info
  rm -f dir
  for f in *
    do install-info "$f" dir 2>/dev/null
  done
popd
