#!/bin/bash

# check user privileges
if [ $UID -ne 0 ]; then
  echo "This program needs superuser's privileges"
  exit 1
fi

cp ./desktopgen.sh /usr/local/bin/desktopgen
