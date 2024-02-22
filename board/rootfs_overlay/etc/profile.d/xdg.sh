if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

export WAYLAND_DISPLAY="${XDG_RUNTIME_DIR}/wayland-[01]"
export WAYLAND_DISPLAY=$(basename $WAYLAND_DISPLAY)
