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

if "$#" -ne 2; then
    exit 1
fi

input_dir="$1"
output_dir="$2"

if ! -d "$input_dir"; then
    exit 1
fi

mkdir -p "$output_dir"

while IFS= read -r -d $'\0' file; do
    copyFile "$file" "$output_dir"
done < <(find "$input_dir" -type f -print0)