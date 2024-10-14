#!/bin/bash

save_pat_password () {
PAT_PASSWORD=$(yad --title="Winlink Password..." \
--window-icon="dialog-password-symbolic" \
--form --borders=36 \
--center \
--fixed \
--field="Winlink Password" \
--text="Enter Winlink password, or leave empty to continue without setting a password.\n" \
--buttons-layout=end)

PAT_PASSWORD=$(echo -n "$PAT_PASSWORD" | sed 's/|//')

sed -i 's/^.*"secure_login_password": ".*",$/  "secure_login_password": "'"$PAT_PASSWORD"'",/' $HOME/.config/pat/config.json

sudo systemctl restart pat@user.service

notify-send --urgency=critical --icon=pat-custom-icon "PAT WLNK" "Password set! To save the password persistently, use\n\n'Menu > arcOS Tools > SAVE PAT WLNK CONFIG'.\n\nClick to dismiss this message."
}

save_pat_password
