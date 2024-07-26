#!/bin/bash

gtk-launch start-direwolf.desktop > /dev/null 2>&1 &

sleep 5

gtk-launch yaac.desktop > /dev/null 2>&1 &
