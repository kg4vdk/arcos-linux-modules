#!/bin/bash

#######################
# VSCODIUM QRV MODULE #
#######################
MODULE="VSCODIUM"

# STATION INFO
source $HOME/.station-info

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/CORE/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p "${SAVE_DIR}"/{"vscode-oss","VSCodium"}

unlink "$HOME/.vscode-oss"
rm -rf "$HOME/.vscode-oss"
ln -sTf "${SAVE_DIR}/vscode-oss" "$HOME/.vscode-oss"

unlink "$HOME/.config/VSCodium"
rm -rf "$HOME/.config/VSCodium"
ln -sTf "${SAVE_DIR}/VSCodium" "$HOME/.config/VSCodium"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"