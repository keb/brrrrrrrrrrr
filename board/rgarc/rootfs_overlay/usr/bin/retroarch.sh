#!/bin/sh

export HOME=/root

exec chrt -r 99 /usr/bin/retroarch "$@"
