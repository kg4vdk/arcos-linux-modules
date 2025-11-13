#!/bin/bash

ARCOS_DATA=/arcHIVE

source $HOME/.station-info

OPERATOR="${MYCALL}"
TIMESTAMP=$(date +"%F_%H%M%Z")

# Kill any running CORE module applications
echo "Closing any relevant applications..."
killall direwolf ardopcf > /dev/null 2>&1
killall VARAFM.exe VARA.exe > /dev/null 2>&1
killall fldigi flamp flmsg flrig rigctl rigctld > /dev/null 2>&1
killall js8call wsjtx > /dev/null 2>&1
killall warpinator > /dev/null 2>&1
killall java > /dev/null 2>&1
killall qsstv > /dev/null 2>&1
killall firefox-esr > /dev/null 2>&1
killall thunderbird > /dev/null 2>&1
killall gnome-calendar > /dev/null 2>&1
killall evolution-alarm-notify 2>&1
killall seahorse > /dev/null 2>&1
killall kleopatra > /dev/null 2>&1
killall viking > /dev/null 2>&1
killall hexchat > /dev/null 2>&1
pkill -f paracon > /dev/null 2>&1
pkill -f sticky > /dev/null 2>&1
sleep 1

backup_location () {
BACKUP_DIR="$(yad --file \
--filename="/arcHIVE/" \
--directory \
--center \
--width=720 \
--borders=36 \
--window-icon="document-new-symbolic" \
--title="Select Backup Location..." \
--text-align="center" \
--text="*** If possible, select a backup location other than the arcOS USB drive. ***"
)"
BACKUP_FILE="${BACKUP_DIR}"/"${OPERATOR}"_"${TIMESTAMP}".backup
USER_MODULES_BACKUP_FILE="${BACKUP_DIR}"/"${OPERATOR}"_USER_"${TIMESTAMP}".tar
}

backup_progress () {
yad --progress \
--undecorated \
--center \
--width=500 \
--borders=36 \
--window-icon="document-new-symbolic" \
--title="Creating $(basename "${BACKUP_FILE}")..." \
--text="Creating $(basename "${BACKUP_FILE}")..." \
--pulsate \
--enable-log="Backup Log" \
--log-expanded \
--log-height=250 \
--auto-kill \
--auto-close \
--no-escape \
--no-buttons
}

backup_operator () {
if [ -f ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup ]; then
	mv ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup /tmp/.last-backup_old
	echo "IN PROGRESS..." > ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
else
	echo "IN PROGRESS..." > ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
fi

echo "${TIMESTAMP}" > /tmp/.last-backup

tar -cvf "${BACKUP_FILE}" \
--exclude=.last-backup \
-C /arcHIVE/QRV ${OPERATOR} LOGS \
-C /arcHIVE .operators/station-info_${OPERATOR} .station-info \
-C /tmp .last-backup \
| while read -r line; do echo "# ${line}"; done \

tar -rf "${BACKUP_FILE}" \
-C /tmp .last-backup \
| while read -r line; do echo "# ${line}"; done \

if [ -d /arcHIVE/QRV/.packages ]; then
tar -rf "${BACKUP_FILE}" \
-C /arcHIVE/QRV .packages \
| while read -r line; do echo "# ${line}"; done \
fi

ISO_VER=$(grep "^PRETTY_NAME" /etc/os-release | awk -F " " '{print $1}' | awk -F '\"' '{print $2}')
MODULES_VER=$(head -n 1 /tmp/modules.log)
cd ${ARCOS_DATA}/QRV/${OPERATOR}/arcos-linux-modules
#git config --global --add safe.directory ${ARCOS_DATA}/QRV/${OPERATOR}/arcos-linux-modules
BRANCH=$(git branch --show-current)
MODULES_VER_FULL=$(tail -n 1 ${ARCOS_DATA}/QRV/${OPERATOR}/arcos-linux-modules/.git/refs/heads/$BRANCH)
MODULES_DATE=$(git show --no-patch --format=%ci "${MODULES_VER_FULL}")
# Set new MODULES_VER
MODULES_VER="${MODULES_VER} ${MODULES_DATE}"

echo "${OPERATOR}" > /tmp/backup_info
echo "${ISO_VER}" >> /tmp/backup_info
echo "${MODULES_VER}" >> /tmp/backup_info
if [ -d ${ARCOS_DATA}/QRV/.packages ];then
	echo "PACKAGES" >> /tmp/backup_info
fi

tar -rf "${BACKUP_FILE}" \
-C /tmp backup_info \
| while read -r line; do echo "# ${line}"; done

rm /tmp/backup_info

if [ ! -z "$(ls -A ${ARCOS_DATA}/QRV/${OPERATOR}/arcos-linux-modules/USER)" ]; then
tar -cvf "${USER_MODULES_BACKUP_FILE}" \
-C /arcHIVE/QRV/${OPERATOR}/arcos-linux-modules USER \
| while read -r line; do echo "# ${line}"; done \
fi
}

backup_location

if [[ "${BACKUP_DIR}" != "" ]]; then
	notify-send --icon=document-new-symbolic "Backup Started!" "Files included:\n   + /arcHIVE/.station-info\n   + /arcHIVE/.operators/${OPERATOR}_station-info\n   + /arcHIVE/QRV/${OPERATOR}/*\n   + /arcHIVE/QRV/LOGS\n   + /arcHIVE/QRV/.packages (if it exists)\n\n***Offline maps are NOT included! ***\n   - /arcHIVE/QRV/OFFLINE-MAPS"
	if backup_operator | backup_progress; then
		mv /tmp/.last-backup ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
		if [ -f "${USER_MODULES_BACKUP_FILE}" ]; then
			notify-send --icon=document-new-symbolic "Backup Complete!" "File: $(basename "${BACKUP_FILE}")\nSize: $(du -sh "${BACKUP_FILE}" | awk -F " " '{print $1}')\n\nFile: $(basename "${USER_MODULES_BACKUP_FILE}")\nSize: $(du -sh "${USER_MODULES_BACKUP_FILE}" | awk -F " " '{print $1}')"
		else
			notify-send --icon=document-new-symbolic "Backup Complete!" "File: $(basename "${BACKUP_FILE}")\nSize: $(du -sh "${BACKUP_FILE}" | awk -F " " '{print $1}')"
		fi
	else
		notify-send --icon=error "Backup Failed!"
		echo "FAILED..." > ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
		sleep 2
		if [ -f /tmp/.last-backup_old ]; then
			mv /tmp/.last-backup_old ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
		else
			rm ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup > /dev/null 2>&1		
		fi
	fi
else
	notify-send --icon=document-new-symbolic "Backup Canceled!"
	echo "CANCELED..." > ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
	sleep 2
	if [ -f /tmp/.last-backup_old ]; then
		mv /tmp/.last-backup_old ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup
	else
		 rm ${ARCOS_DATA}/QRV/${OPERATOR}/.last-backup > /dev/null 2>&1
	fi
fi
