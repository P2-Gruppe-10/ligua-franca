#!/usr/bin/env bash
if [[ "$1" == "--help" ]]; then
    echo "usage: display-graph-update.sh <file-path>"
    exit
fi

old=""
while inotifywait -qe modify "$1" >/dev/null; do
    new=$(cat "$1")
    if [[ "$new" != "$old" ]]; then
        clear
        jq <<<"$new"
        old="$new"
    fi
done
