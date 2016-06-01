#!/bin/sh

# Stop Xserver so chromium can auto restore
/usr/sbin/service lightdm stop
# Reboot
/sbin/reboot