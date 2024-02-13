#!/bin/sh

joypad_dev=/dev/input/by-path/platform-gpio-keys-control-event-joystick
mode_dev=/dev/input/by-path/platform-adc-keys-event-joystick

case "$1" in
    button/power)
        /sbin/poweroff
        ;;
    button/volumeup)
        if ! evtest --query $mode_dev EV_KEY BTN_MODE; then
            brightnessctl s 1%+ -n 1 -q
        elif ! evtest --query $joypad_dev EV_KEY BTN_SELECT; then
	    iwctl device wlan0 set-property Powered on
        else
            amixer sset Master 1%+ -q
        fi
        ;;
    button/volumedown)
        if ! evtest --query $mode_dev EV_KEY BTN_MODE; then
            brightnessctl s 1%- -n 1 -q
        elif ! evtest --query $joypad_dev EV_KEY BTN_SELECT; then
	    iwctl device wlan0 set-property Powered off
        else
            amixer sset Master 1%- -q
        fi
        ;;
esac
