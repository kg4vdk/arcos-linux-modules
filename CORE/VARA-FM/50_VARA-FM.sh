#!/bin/bash

######################
# VARA-FM QRV MODULE #
######################
MODULE="VARA-FM"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

install_varafm () {
export WINEARCH=win32
export WINEPREFIX=$HOME/.wine_varafm_32
echo "5"

winetricks winxp
echo "10"
winetricks sound=alsa
echo "15"

#if ping -c 5 8.8.8.8 > /dev/null; then
	mkdir -p $HOME/.cache/winetricks/vb6run
	cp $MODULE_DIR/exe/VB6.0-KB290887-X86.exe $HOME/.cache/winetricks/vb6run/
	winetricks -q vb6run
	echo "45"
	mkdir -p $HOME/.cache/winetricks/vcrun2015
	cp $MODULE_DIR/exe/vc_redist.x64.exe $HOME/.cache/winetricks/vcrun2015/
	winetricks -q vcrun2015
	echo "55"
#else
#	notify-send --icon=error --urgency=critical "VARA-FM" "Internet connection required for installation."
#	exit
#fi

cp $MODULE_DIR/dll/pdh.dll $HOME/.wine_varafm_32/drive_c/windows/system32

wine reg add "HKLM\Software\Wine\Ports" /v COM1 /d /dev/digirig /t REG_SZ /f
echo "60"

unzip -o -d /tmp $MODULE_DIR/"VARA FM v4.3.8 setup.zip"
echo "70"

echo "75"
wine /tmp/"VARA FM setup (Run as Administrator)".exe
sleep 0.5
echo "80"
killall VARAFM.exe
echo "85"

cp $MODULE_DIR/config/VARAFM.ini $HOME/.wine_varafm_32/drive_c/VARA\ FM/VARAFM.ini
echo "90"

sed -i "s/XXXCALLSIGNXXX/$MYCALL/" $HOME/.wine_varafm_32/drive_c/VARA\ FM/VARAFM.ini
echo "95"

mkdir -p $SAVE_DIR/{icons,applications}
tar -C $HOME -cf $SAVE_DIR/wine_vara-fm.tar .wine_varafm_32
echo "97"

cp $HOME/.local/share/icons/hicolor/48x48/apps/253F_VARAFM.0.png $SAVE_DIR/icons/
cp $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop $SAVE_DIR/applications/
echo "99"

sudo cp $MODULE_DIR/save-vara-fm.sh /opt/arcOS/bin/
cp $MODULE_DIR/save-vara-fm.desktop $HOME/.local/share/applications/
echo "100"
sleep 2
}

export -f install_varafm

register_varafm () {
LICENSE=$(yad --title="VARA Registration..." \
--window-icon="dialog-password-symbolic" \
--form --borders=36 \
--center \
--fixed \
--field="VARA Registration Code" \
--text="Enter VARA Registration Code, or leave empty to continue without registration.\n\nYou can add a registration code later by copying the code into the 'LICENSE' file in the\n/ARCOS-DATA/QRV/${MYCALL}/SAVED/VARA-FM directory." \
--buttons-layout=end)

LICENSE=$(echo -n "$LICENSE" | sed 's/|//')
echo "$LICENSE" > $SAVE_DIR/LICENSE

sed -i 's/^Registration Code=.*$/Registration Code='"$LICENSE"'/' $HOME/.wine_varafm_32/drive_c/VARA\ FM/VARAFM.ini
}


if [ -f $SAVE_DIR/wine_vara-fm.tar ]; then
	mkdir -p $HOME/.local/share/icons/hicolor/48x48/apps
	cp $SAVE_DIR/icons/253F_VARAFM.0.png  $HOME/.local/share/icons/hicolor/48x48/apps/
	mkdir -p $HOME/.local/share/applications/wine/Programs/VARA\ FM
	cp $SAVE_DIR/applications/VARA\ FM.desktop $HOME/.local/share/applications/wine/Programs/VARA\ FM/
	if ! grep "Categories" $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop > /dev/null; then
		echo "Categories=Wine" >> $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop
	fi
	tar -C $HOME -xf $SAVE_DIR/wine_vara-fm.tar
	export WINEARCH=win32
	export WINEPREFIX=$HOME/.wine_varafm_32
	wine reg add "HKLM\Software\Wine\Ports" /v COM1 /d /dev/digirig /t REG_SZ /f
	if [ -f $SAVE_DIR/LICENSE ]; then
		LICENSE=$(cat $SAVE_DIR/LICENSE)
		sed -i 's/^Registration Code=.*$/Registration Code='"$LICENSE"'/' $HOME/.wine_varafm_32/drive_c/VARA\ FM/VARAFM.ini
	fi
	sudo cp $MODULE_DIR/save-vara-fm.sh /opt/arcOS/bin/
	cp $MODULE_DIR/save-vara-fm.desktop $HOME/.local/share/applications/
else
	if command -v wine > /dev/null; then
		notify-send --icon=gnome-break-timer "Deploying VARA-FM Module for the first time..."
		vara_progress () {
		echo "5"
		install_varafm
		register_varafm
		notify-send --icon=info "VARA-FM" "VARA-FM is installed, and is available in the Wine category of the Main Menu."
		}
		vara_progress | yad --progress \
  		--window-icon=wine \
		--fixed \
		--center \
		--width=300 \
		--borders=36 \
		--title="VARA-FM" \
		--text="Installing VARA-FM..." \
		--auto-close
	else
		notify-send --icon=error --urgency=critical "VARA-FM" "To enable compatibility with VARA, you may purchase a license key for arcOS at https://arcos-linux.com.\n\nPlease consider using the included open source modems instead."
	fi
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
