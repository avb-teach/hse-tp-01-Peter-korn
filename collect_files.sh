#!/bin/bash

set -e
set -u

copyFile() {
    local filePath="$1"
    local directoryPath="$2"
    local fileName=$(basename "$filePath")
    local name="${fileName%.*}"
    local extension="${fileName##*.}"

    local target="$directoryPath/$fileName"
    local counter=1

    while [ -e "$target" ]; do
        if [ "$name" = "$extension" ]; then
            target="$directoryPath/${name}${counter}"
        else
            target="$directoryPath/${name}${counter}.${extension}"
        fi
        counter=$((counter + 1))
    done

    cp "$filePath" "$target"
}