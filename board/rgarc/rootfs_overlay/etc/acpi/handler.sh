#!/bin/sh

device=/dev/input/by-path/platform-singleadc-joypad-event-joystick

case "$1" in
    button/power)
        if ! evtest --query $device EV_KEY BTN_TL; then
            /sbin/reboot
        else
            /sbin/poweroff
        fi
        ;;
    button/volumeup)
        if ! evtest --query $device EV_KEY BTN_MODE; then
            brightnessctl s 1%+ -n 1 -q
        elif ! evtest --query $device EV_KEY BTN_SELECT; then
            /etc/init.d/K50net start
        else
            amixer sset Master 1%+ -q
        fi
        ;;
    button/volumedown)
        if ! evtest --query $device EV_KEY BTN_MODE; then
            brightnessctl s 1%- -n 1 -q
        elif ! evtest --query $device EV_KEY BTN_SELECT; then
            /etc/init.d/K50net stop
        else
            amixer sset Master 1%- -q
        fi
        ;;
esac
