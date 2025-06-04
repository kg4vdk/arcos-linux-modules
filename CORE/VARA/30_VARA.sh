#!/bin/bash

######################
# VARA QRV MODULE #
######################
MODULE="VARA"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

export WINEARCH=win32
export WINEPREFIX=$HOME/.wine_vara_32

prepare_vara () {
echo "15"

winetricks winxp
echo "30"

winetricks sound=alsa
echo "45"

mkdir -p $HOME/.cache/winetricks/vb6run
cp $MODULE_DIR/exe/VB6.0-KB290887-X86.exe $HOME/.cache/winetricks/vb6run/
winetricks -q vb6run
echo "60"

mkdir -p $HOME/.cache/winetricks/vcrun2015
cp $MODULE_DIR/exe/vc_redist.x86.exe $HOME/.cache/winetricks/vcrun2015/
winetricks -q vcrun2015
echo "75"

cp $MODULE_DIR/dll/pdh.dll $HOME/.wine_vara_32/drive_c/windows/system32
echo "85"

wine reg add "HKLM\Software\Wine\Ports" /v COM1 /d /dev/digirig /t REG_SZ /f
wine reg add "HKCU\Software\Wine\Drivers\winealsa.drv" /v ALSAInputDevices /d digirig-rx /t REG_MULTI_SZ /f
wine reg add "HKCU\Software\Wine\Drivers\winealsa.drv" /v ALSAOutputDevices /d digirig-tx /t REG_MULTI_SZ /f
echo "100"
}

install_vara () {
unzip -o -d /tmp $MODULE_DIR/"VARA FM v4.3.8 setup.zip"
wine /tmp/"VARA FM setup (Run as Administrator)".exe
sleep 1
if pidof "C:\VARA FM\VARAFM.exe"; then
	killall VARAFM.exe
fi

unzip -o -d /tmp $MODULE_DIR/"VARA HF v4.8.9 setup.zip"
wine /tmp/"VARA setup (Run as Administrator)".exe
sleep 1
if pidof "C:\VARA\VARA.exe"; then
	killall VARA.exe
fi
}

config_vara () {
cp $MODULE_DIR/config/VARAFM.ini $HOME/.wine_vara_32/drive_c/VARA\ FM/VARAFM.ini
sed -i "s/XXXCALLSIGNXXX/$MYCALL/" $HOME/.wine_vara_32/drive_c/VARA\ FM/VARAFM.ini

cp $MODULE_DIR/config/VARA.ini $HOME/.wine_vara_32/drive_c/VARA/VARA.ini
sed -i "s/XXXCALLSIGNXXX/$MYCALL/" $HOME/.wine_vara_32/drive_c/VARA/VARA.ini
sudo cp $MODULE_DIR/bin/start-vara-hf.sh /opt/arcOS/bin/
cp $MODULE_DIR/applications/VARA.desktop $HOME/.local/share/applications/wine/Programs/VARA/
}

persist_vara () {
mkdir -p $SAVE_DIR/{icons,applications}

tar -C $HOME -cf $SAVE_DIR/wine_vara.tar .wine_vara_32

cp $MODULE_DIR/icons/C497_VARAFM.0.png $SAVE_DIR/icons/
cp $MODULE_DIR/icons/C497_VARAFM.0.png $HOME/.local/share/icons/hicolor/48x48/apps/
cp $MODULE_DIR/applications/VARA\ FM.desktop $SAVE_DIR/applications/
cp $MODULE_DIR/icons/F302_VARA.0.png $SAVE_DIR/icons/
cp $MODULE_DIR/icons/F302_VARA.0.png $HOME/.local/share/icons/hicolor/48x48/apps/
cp $MODULE_DIR/applications/VARA.desktop $SAVE_DIR/applications/
}

register_vara () {
REG_CODE=$(yad --title="VARA Registration..." \
--window-icon="dialog-password-symbolic" \
--undecorated \
--form --borders=36 \
--center \
--fixed \
--field="" \
--text="Enter VARA Registration Code, or leave empty to continue without registration.\n\n" \
--no-ecscape \
--button="OK" \
--buttons-layout=end)

REG_CODE=$(echo -n "$REG_CODE" | sed 's/|//')
echo "$REG_CODE" > $SAVE_DIR/REGISTRATION_CODE

sed -i 's/^Registration Code=.*$/Registration Code='"$REG_CODE"'/' $HOME/.wine_vara_32/drive_c/VARA\ FM/VARAFM.ini
sed -i 's/^Registration Code=.*$/Registration Code='"$REG_CODE"'/' $HOME/.wine_vara_32/drive_c/VARA/VARA.ini
}

progress_window () {
yad --progress \
--undecorated \
--window-icon=wine \
--fixed \
--center \
--width=300 \
--borders=36 \
--title="Wine" \
--text="Preparing Wine environment..." \
--no-buttons \
--no-escape \
--auto-close
}

remove_vara () {
rm -rf $SAVE_DIR
rm -rf $HOME/.wine_vara_32
rm $HOME/.local/share/icons/hicolor/48x48/apps/C497_VARAFM.0.png
rm -rf $HOME/.local/share/applications/wine/Programs/VARA\ FM
rm $HOME/.local/share/icons/hicolor/48x48/apps/F302_VARA.0.png
rm -rf $HOME/.local/share/applications/wine/Programs/VARA
}

deploy_vara () {
if [ -f $SAVE_DIR/wine_vara.tar ]; then
	mkdir -p $HOME/.local/share/icons/hicolor/48x48/apps
	cp $SAVE_DIR/icons/C497_VARAFM.0.png  $HOME/.local/share/icons/hicolor/48x48/apps/
	mkdir -p $HOME/.local/share/applications/wine/Programs/VARA\ FM
	cp $SAVE_DIR/applications/VARA\ FM.desktop $HOME/.local/share/applications/wine/Programs/VARA\ FM/
	cp $SAVE_DIR/icons/F302_VARA.0.png  $HOME/.local/share/icons/hicolor/48x48/apps/
	mkdir -p $HOME/.local/share/applications/wine/Programs/VARA
	sudo cp $MODULE_DIR/bin/start-vara-hf.sh /opt/arcOS/bin/
	cp $SAVE_DIR/applications/VARA.desktop $HOME/.local/share/applications/wine/Programs/VARA/
	if ! grep "Categories" $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop > /dev/null; then
		echo "Categories=Wine" >> $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop
	fi
	if ! grep "Categories" $HOME/.local/share/applications/wine/Programs/VARA/VARA.desktop > /dev/null; then
		echo "Categories=Wine" >> $HOME/.local/share/applications/wine/Programs/VARA/VARA.desktop
	fi
	tar -C $HOME -xf $SAVE_DIR/wine_vara.tar
	wine reg add "HKLM\Software\Wine\Ports" /v COM1 /d /dev/digirig /t REG_SZ /f
	wine reg add "HKCU\Software\Wine\Drivers\winealsa.drv" /v ALSAInputDevices /d digirig-rx /t REG_MULTI_SZ /f
	wine reg add "HKCU\Software\Wine\Drivers\winealsa.drv" /v ALSAOutputDevices /d digirig-tx /t REG_MULTI_SZ /f
	if [ -f $SAVE_DIR/REGISTRATION_CODE ]; then
		REG_CODE=$(cat $SAVE_DIR/REGISTRATION_CODE)
		sed -i 's/^Registration Code=.*$/Registration Code='"$REG_CODE"'/' $HOME/.wine_vara_32/drive_c/VARA\ FM/VARAFM.ini
		sed -i 's/^Registration Code=.*$/Registration Code='"$REG_CODE"'/' $HOME/.wine_vara_32/drive_c/VARA/VARA.ini
	fi
else
	if command -v wine > /dev/null; then
		if prepare_vara | progress_window; then
			if install_vara && config_vara && persist_vara && register_vara; then
				notify-send --urgency=critical --icon=info "VARA" "VARA is installed, and will be available in the Wine category of the Main Menu.\n\nClick to dismiss this message."
			else
				remove_vara
				notify-send --icon=error "$MODULE" "$MODULE installation failed!"
			fi
		else
			remove_vara
			notify-send --icon=error "$MODULE" "$MODULE installation failed!"
		fi
	else
		notify-send --icon=error --urgency=critical "VARA" "To enable compatibility with VARA, you may purchase an unlock key for arcOS at https://arcos-linux.com.\n\nPlease consider using the included open source modems instead."
	fi
fi
}

deploy_vara

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
