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

notify-send --icon=pat-custom-icon "PAT WLNK" "Password set!\n\nTo save the password persistently, use 'Menu > arcOS Tools > SAVE PAT WLNK CONFIG'."
}

save_pat_password
