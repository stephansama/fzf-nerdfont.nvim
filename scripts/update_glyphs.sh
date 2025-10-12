#!/usr/bin/env bash

set -o pipefail

OUTPUT="${GLYPHS_DIR}/glyphnames"

rm -f "$OUTPUT"

curl -s 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json' \
    | jq 'to_entries | map([.key, .value.char]) | del(.[0]) | .[] | reverse | join(" ")' \
    | tr -d '"' >| "$OUTPUT"
