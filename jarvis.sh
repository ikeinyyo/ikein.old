#!/bin/bash

JARVIR_DIR_PATH=.jarvis.d/*.sh

load_modules() {
    JARVIS_MODULES=()
    echo "Loading modules..."
    for file in $JARVIR_DIR_PATH; do
        source "$file"
        JARVIS_MODULES=($(echo ${JARVIS_MODULES[*]}) $(echo ${FUNCTIONS[*]}))
        echo "[OK] $file"
    done
}

containsElement() {
    local e match="$1"
    shift
    for e; do [[ "$e" == "$match" ]] && return 0; done
    return 1
}

jarvis() {
    if containsElement "$1" "${JARVIS_MODULES[@]}"; then
        echo "Command found"
        $1
    else
        echo "Command not found"
    fi
}

load_modules

if [ $# = 0 ]; then
    echo "Add command"
else
    jarvis $1
fi
