#!/bin/bash

IKEIN_DIR_PATH=.ikein.d/*.sh

load_modules() {
    IKEIN_MODULES=()
    echo "Loading modules..."
    for file in $IKEIN_DIR_PATH; do
        source "$file"
        IKEIN_MODULES=($(echo ${IKEIN_MODULES[*]}) $(echo ${FUNCTIONS[*]}))
        echo "[OK] $file"
    done
}

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

ikein() {
    ikein_command="ikein_$1"
    if containsElement ${ikein_command} "${IKEIN_MODULES[@]}"; then
        echo "Command found"
        $ikein_command
    else
        echo "Command not found"
    fi
}

load_modules

if [ $# = 0 ]; then
    echo "Add command"
else
    ikein $1
fi
