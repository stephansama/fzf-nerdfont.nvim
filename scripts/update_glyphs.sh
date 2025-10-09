#!/usr/bin/env bash

set -o pipefail

# OUTPUT="lua/fzf-nerdfont/glyphnames"
OUTPUT="$(nvim --headless --clean -c 'echo stdpath("data")' -c 'qa!' 2>&1)/glyphnames"

rm -f "$OUTPUT"

curl -s 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json' \
    | jq 'to_entries | map([.key, .value.char]) | del(.[0]) | .[] | reverse | join(" ")' >| "$OUTPUT"
