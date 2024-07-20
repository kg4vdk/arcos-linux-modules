#!/bin/bash

sed -i 's/gap_y = 48/gap_y = 64/' ~/.conkyrc

gsettings set org.cinnamon panels-height "['1:60']"

gsettings set org.cinnamon panel-zone-icon-sizes '[{"panelId": 1, "left": 48, "center": 0, "right": 0}]'

gsettings set org.cinnamon panel-zone-symbolic-icon-sizes '[{"panelId": 1, "left": 0, "center": 0, "right": 24}]'

gsettings set org.cinnamon.desktop.interface font-name 'Ubuntu 14'

gsettings set org.nemo.desktop font 'Ubuntu Bold 14'

