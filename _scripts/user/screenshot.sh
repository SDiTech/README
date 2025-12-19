#!/bin/sh

path="$HOME/Pictures/Screenshots/"
filename="`date "+%Y-%m-%d_%H-%M-%S"`_screenshot.png"
screenshot="$path$filename"
/usr/bin/import $screenshot
chmod 0600 $screenshot
