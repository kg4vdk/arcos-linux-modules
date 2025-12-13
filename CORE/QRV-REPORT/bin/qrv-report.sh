#!/bin/bash

# STATION INFO
source $HOME/.station-info

# Timestamp
TIMESTAMP=$(date +"%F_%H%M%Z")

# Boot device
BOOT_PARTITION=$(df -h | grep cdrom | awk -F " " '{print $1}')
if [[ $BOOT_PARTITION == *"nvme"* ]]; then
	DISK=${BOOT_PARTITION%??}
	EXFAT_PARTITION="p3"
elif [[ $BOOT_PARTITION == *"mmcblk"* ]]; then
    DISK=${BOOT_PARTITION%??}
	EXFAT_PARTITION="p3"
else
	DISK=${BOOT_PARTITION%?}
	EXFAT_PARTITION="3"
fi

# Operator callsign
if [ -f /home/user/.station-info ]; then
	OPERATOR="${MYCALL}"
else
	OPERATOR="arcOS"
fi

# QRV timestamp
QRV_TIME=$(awk '{print int($1/3600)"h "int(($1%3600)/60)"m "int($1%60)"s"}' /proc/uptime)

# arcOS Version
ARCOS_VERSION=$(grep "^PRETTY_NAME" /etc/os-release | awk -F " " '{print $1}' | awk -F '\"' '{print $2}')

# Modules Version
if [ -f /tmp/modules.log ]; then
	MODULES_VERSION=$(exec head -n 1 /tmp/modules.log)
fi

# QRV Report (messy)
QRV_REPORT_FULL=$(inxi --machine --cpu --memory-short)

# Machine Manufacturer
MACHINE_MANUFACTURER=$(echo "${QRV_REPORT_FULL}" | grep "Type:" | grep "System:" | awk -F " product:" '{print $1}' | awk -F "System: " '{print $2}')

# Machine Model
MACHINE_MODEL=$(echo "${QRV_REPORT_FULL}" | grep "Type:" | grep "System:" | awk -F "v: " '{print $2}')

# Product Code
PRODUCT_CODE=$(echo "${QRV_REPORT_FULL}" | grep "Type:" | awk -F "product: " '{print $2}' | awk -F " v:" '{print $1}')

# CPU Info
CPU_INFO=$(echo "${QRV_REPORT_FULL}" | grep "Info:" | awk -F "bits:" '{print $1}' | awk -F "model: " '{print $2}')

# Memory Info
MEMORY_INFO=$(echo "${QRV_REPORT_FULL}" | grep "System RAM:" | awk -F "available:" '{print $1}' | awk -F "total: " '{print $2}')

# QRV Report
if [ ! -z "${OPERATOR}" ]; then
	echo
	echo "# QRV REPORT FOR ${OPERATOR} @ ${TIMESTAMP} #" | tee /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
fi
echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "### **Time to QRV: ${QRV_TIME}** ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "### SYSTEM ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "OS Info:    ${ARCOS_VERSION}$(if [ -f /tmp/.valid_key ]; then echo ' (Unlocked)'; fi)" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "Modules:    ${MODULES_VERSION}" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "Machine:    ${MACHINE_MANUFACTURER} ${MACHINE_MODEL}" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "Prod. Code: ${PRODUCT_CODE}" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "CPU Info:   ${CPU_INFO}" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "Total RAM:  ${MEMORY_INFO}" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "### ARCOS DEVICE ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
if [ "${BOOT_PARTITION}" == "/dev/shm" ] || [ "${BOOT_PARTITION}" == "/dev/mapper/ventoy" ] || [ "${BOOT_PARTITION}" == "/dev/sr0" ]; then
	echo -e "**Booted to ${BOOT_PARTITION}**" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
else
	lsblk -o PATH,SIZE,VENDOR,MODEL ${DISK} | head -n 2 | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
fi
if [ -d /arcHIVE/QRV/OFFLINE-MAPS ]; then
	if [ ! -z "$( ls -A /arcHIVE/QRV/OFFLINE-MAPS)" ]; then
		echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		echo "### OFFLINE-MAPS ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		cd /arcHIVE/QRV
		du -sh OFFLINE-MAPS | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
	fi
fi
if [ -d /arcHIVE/QRV/${OPERATOR}/SAVED/PROFILES ]; then
	if [ ! -z "$( ls -A /arcHIVE/QRV/${OPERATOR}/SAVED/PROFILES)" ]; then
		echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		echo "### QRV PROFILES ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		cd /arcHIVE/QRV/${OPERATOR}/SAVED/PROFILES
		ls | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
	fi
fi
if [ -d /arcHIVE/QRV/${OPERATOR}/arcos-linux-modules/USER ]; then
	if [ ! -z "$( ls -A /arcHIVE/QRV/${OPERATOR}/arcos-linux-modules/USER)" ]; then
		echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		echo "### USER MODULES ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		cd /arcHIVE/QRV/${OPERATOR}/arcos-linux-modules/USER
		ls | grep ".sh" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
	fi
fi
if [ -d /arcHIVE/QRV/.packages ];then
	if [ ! -z "$( ls -A /arcHIVE/QRV/.packages)" ]; then
		echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		echo "### PACKAGES ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
		cd /arcHIVE/QRV/.packages
		ls -R * | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
	fi
fi
echo | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "### END QRV REPORT ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "---" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "### USER COMMENTS ###" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo "[OPTIONAL]" | tee --append /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt
echo
mv /tmp/${OPERATOR}_QRV_${TIMESTAMP}.txt /arcHIVE/${OPERATOR}_QRV_${TIMESTAMP}.txt
notify-send --urgency=critical --icon=text-x-generic-symbolic "QRV Report generated for ${OPERATOR}!" "File: /arcHIVE/${OPERATOR}_QRV_${TIMESTAMP}.txt\n\nClick to dismiss this message."
if pidof ffplay > /dev/null 2>&1; then
	echo "Let it play, or..."
	read -p "Press the [ANY KEY] to exit!"
	echo
	killall ffplay > /dev/null 2>&1
fi
