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

mkdir -p ~/.local/share/tetosong
curl -L -o ~/.local/share/tetosong/tetofortunes https://github.com/eric5949/TetoSongOfTheDay/raw/a52c877bfb1508f0223469e3b9e86c65ee6915ae/tetofortunes
curl -L -o ~/.local/share/tetosong/tetofortunes.dat https://github.com/eric5949/TetoSongOfTheDay/raw/a52c877bfb1508f0223469e3b9e86c65ee6915ae/tetofortunes.dat

cat > ~/.local/bin/tetosong <<EOF
#!/bin/bash
if ! [ -x "$(command -v fortune)" ]; then
  echo 'fortune is not installed, checking for misfortune' >&2
  if ! [ -x "$(command -v misfortune)" ]; then
      echo 'neither program is installed, exiting' >&2
      exit 1
  fi
else
    fortune ~/.local/share/tetosong/tetofortunes
fi
EOF

chmod +x ~/.local/bin/tetosong


echo "you can get your Teto Song Of the Day by typing in tetosong or adding it to your bashrc :)"
