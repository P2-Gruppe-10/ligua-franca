#!/usr/bin/env bash
# macOS-compatible replacement for an inotifywait-based watcher using fswatch

if [[ "$1" == "--help" || -z "$1" ]]; then
  echo "usage: display-graph-update.sh <file-path>"
  exit
fi

file="$1"

if [[ ! -e "$file" ]]; then
  echo "error: file not found: $file" >&2
  exit 2
fi

old=""

# fswatch emits NUL-separated records with -0; handle filenames safely.
fswatch -0 "$file" | while IFS= read -r -d '' event; do
  # ensure the file still exists (it might be replaced)
  if [[ ! -e "$file" ]]; then
    continue
  fi

  new=$(cat "$file")
  if [[ "$new" != "$old" ]]; then
    clear
    # pipe to jq (works even if $new contains newlines)
    printf '%s' "$new" | jq
    old="$new"
  fi
done
