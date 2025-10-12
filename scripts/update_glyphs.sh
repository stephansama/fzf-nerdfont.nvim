#!/usr/bin/env bash

set -o pipefail

function get_default_dir() {
	nvim --headless --clean -c 'echo stdpath("data") . "/fzf-nerdfont"' -c 'qa!' 2>&1
}

OUTPUT="${GLYPHS_DIR:-$(get_default_dir)}/glyphnames"

rm -f "$OUTPUT"

curl -s 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json' |
	jq 'to_entries | map([.key, .value.char]) | del(.[0]) | .[] | reverse | join(" ")' |
	tr -d '"' >|"$OUTPUT"
