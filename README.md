# desktop-script-generator

Bash script for generate a simple .desktop script. 
Useful for custom or manual-installed programs. 

## Usage

    USAGE: desktopgen.sh appname executable-path [options]
    generate a simple .desktop script for your program

      OPTIONS:
      -d | --description [description of the program]
      -i | --icon [icon name or iconpath]
      -c | --categories [categories separated by semicolons]
      -t | --terminal Use it if the program must be executed in terminal
      -h print this help

## Examples

```./desktopgen.sh krita /opt/krita-3.2.0-x86_64.appimage -c "image;editor"```