#!/bin/bash

function usage() {
    cat <<EOF
    USAGE: $0 appname executable-path [options]
    generate a simple .desktop script for your program

      OPTIONS:
      -d | --description [description of the program]
      -i | --icon [icon name or iconpath]
      -c | --categories [categories separated by semicolons]
      -t | --terminal Use it if the program must be executed in terminal
      -h print this help
EOF
    return;
}


# check user privileges
if [ $UID -ne 0 ]; then
  echo "This program needs superuser's privileges"
  exit 1
fi

# check help
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
  usage
  exit 0
fi

# need at least 2 args
if [ $# -lt 2 ]; then
  echo "Insuficient args"
  usage
fi

desktop_path=/usr/share/applications
appname=$1
apppath=$2
shift 2

# parse arguments
while [ ! -z "$1" ]; do
  case $1 in
    -d | --description )
      description=$2
      shift 2
      ;;
    -i | --icon )
      icon=$2
      shift 2
      ;;
    -c | --categories )
      categories=$2
      shift 2
      ;;
    -t | --Terminal )
      terminal=true
      shift 1
      ;;
    * )
      echo "wrong option"
      usage
      exit 1
      ;;
  esac
done

# check if files exist
if [ -f "$desktop_path/$appname.desktop" ]; then
  echo "ERROR: $desktop_path/$appname.desktop exist. Aborting..."
  exit 1
fi

if [ ! -x "$apppath" ]; then
  echo "ERROR: the program $apppath don't exist or don't is executable, aborting..."
  exit 1
fi

# generate desktop script
cat > "$desktop_path/$appname.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=$appname
Comment=${description:-"$appname Application"}
Icon=${icon:-$"appname"}
Exec=$apppath
Terminal=${terminal:-"false"}
Categories=${categories:-"aplications;apps"}
EOF

if [ $? -eq 0 ]; then
  echo "$appname.desktop generated OK"
  exit 0
else
  echo "ERROR: generation of $appname.desktop fails."
  exit 1
fi
