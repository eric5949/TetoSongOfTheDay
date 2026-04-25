#!/usr/bin/bash
# download custom fortunes and config file
echo "Updating tetosong..."
# check if the config file exists, if not download it and prompt the user for options.
mkdir -p ~/.local/share/tetosong


mkdir -p ~/.local/share/tetosong/fortunes
mkdir -p ~/.local/share/tetosong/fortunes/tetosotd
curl -sLo ~/.local/share/tetosong/tetofortunes https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/fortunes/tetosotd/tetofortunes
curl -sLo ~/.local/share/tetosong/tetofortunes.dat https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/fortunes/tetosotd/tetofortunes.dat
AUDIO="$(. ~/.local/share/tetosong/tetosong.config; echo $AUDIO)"
if [ "$AUDIO" = "YES" ]; then
    curl -sLo ~/.local/share/tetosong/SOTD.zip https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/audio/teto/SOTD.zip
    mkdir -p ~/.local/share/tetosong/audio/
    mkdir -p ~/.local/share/tetosong/audio/teto/
    unzip -o ~/.local/share/tetosong/SOTD.zip -d ~/.local/share/tetosong/audio/teto/
    rm ~/.local/share/tetosong/SOTD.zip
fi

# set up autoupdater
# # i use systemd, so i use systemd timers.  I'll figure out something for non-systemd users later.
AUTOUPDATE="$(. ~/.local/share/tetosong/tetosong.config; echo $AUTOUPDATE)"
if [ "$AUTOUPDATE" = "YES" ]; then
    # write and enable systemd service file and timer user services
    echo "Auto-Updater enabled, updating service..."
    mkdir -p ~/.config/systemd/user
    curl -sLo ~/.config/systemd/user/tetosong.service https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/autoupdater/tetosong.service
    curl -sLo ~/.config/systemd/user/tetosong.timer https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/autoupdater/tetosong.timer
    systemctl --user daemon-reload
    systemctl --user enable tetosong.timer
    systemctl --user start tetosong.timer
else
    echo "Autoupdater disabled, skipping service update."
fi
# write tetosong to ~/.local/bin and tell the user how to use it.
echo "writing tetosong to ~/.local/bin"
mkdir -p ~/.local/bin
curl -sLo ~/.local/bin/tetosong https://raw.githubusercontent.com/eric5949/tetosong/refs/heads/test/tetosong
chmod +x ~/.local/bin/tetosong
echo "Update complete"
