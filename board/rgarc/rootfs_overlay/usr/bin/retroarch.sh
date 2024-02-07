#!/bin/bash

export HOME=/root

history_file=$(cat .config/retroarch/retroarch.cfg | grep content_history_path | sed -e 's/.*=\(.*\)/\1/' -e 's/"//g')
history_file_abs=$(eval echo $history_file)
last=$(jq -r '.items[0] | "\"\(.core_path)\" \"\(.path)\""' $history_file_abs)

if evtest --query /dev/input/by-path/platform-gpio-keys-control-event-joystick EV_KEY BTN_EAST; then
	last=""
fi

if [ -z "$last" ]; then
	exec chrt -r 99 /usr/bin/retroarch "$@"
else
	eval "exec chrt -r 99 /usr/bin/retroarch -L $last"
fi


