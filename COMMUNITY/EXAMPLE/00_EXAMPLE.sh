#!/bin/bash

######################
# EXAMPLE QRV MODULE #
######################

# Name of the module directory
MODULE="EXAMPLE"

# STATION INFO
source $HOME/.station-info

# PATHS (Defines paths referenced in the module)
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

#############################################################
# Commands here will be run when the module runs.           #
# Below are some examples of common uses for a USER module: #
#############################################################

### Install packages not included in arcOS ###
# To download packages (and any dependencies) for later installation, use `sudo apt install --download-only`,
# and the packages can be found in /var/cache/apt/archives. Copy all the .deb files from /var/cache/apt/archives
# into the "packages" directory. To install packages located in this directory with the module, uncomment the
# following line:

# sudo dpkg -i $MODULE_DIR/packages/*.deb

### Use source built version of software, instead of the included version ###
# If, for example, you wish to use the source built version of FLDIGI instead of the version included from the repo,
# you may do so by completing the build process and copying the binary into /usr/local/bin. The version in /usr/local/bin
# will take precedence over the version in /usr/bin. Once built, place a copy of the executable binary in the EXAMPLE/bin
# directory, and uncomment the following line:

# sudo cp $MODULE_DIR/bin/fldigi /usr/local/bin

### Place shortcut to an application on the Desktop ###
# Application launchers are located in /usr/share/applications and /home/user/.local/share/applications.
# The VARA launchers (if unlocked) are located in /home/user/.local/share/applications/wine/Programs under the VARA and
# VARA FM directories, respectively. You can find the name of the laucher file by running a command like:
#
# ls /home/user/.local/share/applications/wine/Programs/VARA
#
# This will produce the result VARA.desktop. To place the VARA and VARA FM launchers on the Desktop, uncomment the following 4 lines:

# cp $HOME/.local/share/applications/wine/Programs/VARA/VARA.desktop $HOME/Desktop/
# cp $HOME/.local/share/applications/wine/Programs/VARA\ FM/VARA\ FM.desktop $HOME/Desktop/
# chmod +x $HOME/Desktop/VARA.desktop
# chmod +x $HOME/Desktop/VARA\ FM.desktop

##################################################
} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
