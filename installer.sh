#!/usr/bin/bash
#
#  this one is going to get the fortune wrapper set up and all that good stuff.
#
# it needs to check if fortune is installed (or misfortune if not) ans then i need to find out how to find where the fortune files are installed (i have a misfortune folder, but i cant imagine fortune stores them in there)
# then i need to downlaod the tetofortunes and tetofortunes.dat files to that location
#
# then i need to write a script to ~/.local/bin caled tetosong that simply calls either fortune or misfortune (i'll check i guess?)
#

if ! [ -x "$(command -v fortune)" ]; then
  echo 'fortune is not installed, checking for misfortune' >&2
  if ! [ -x "$(command -v misfortune)" ]; then
      echo 'neither program is installed, exiting' >&2
      exit 1
    else
      echo 'misfortune found' >&2
  fi
else
    echo 'fortune found' >&2
fi

mkdir -p ~/.local/share/fortune
curl -L -o ~/.local/share/fortune/tetofortunes https://gitea.cloudaf.cc/eric/TetoSongOfTheDay/raw/branch/main/tetofortunes
curl -L -o ~/.local/share/fortune/tetofortunes.dat https://gitea.cloudaf.cc/eric/TetoSongOfTheDay/raw/branch/main/tetofortunes.dat

#cat > $wineprefix_path/tetosong <<EOF
#!/bin/bash
#if ! [ -x "$(command -v fortune)" ]; then
#  echo 'fortune is not installed, checking for misfortune' >&2
#  if ! [ -x "$(command -v misfortune)" ]; then
#      echo 'neither program is installed, exiting' >&2
#      exit 1
#    else
#      echo 'misfortune found' >&2
#  fi
#else
#    fortune ~/.local/share/tetofortunes/tetofortunes
#fi
#EOF
