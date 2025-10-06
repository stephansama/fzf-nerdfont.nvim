#!/usr/bin/env bash

output="lua/fzf-nerdfont/glyphnames"

rm "$output"

curl -s https://raw.githubusercontent.com/ryanoasis/nerd-fonts/refs/heads/master/glyphnames.json |
	jq 'to_entries | map([.key, .value.char]) | del(.[0]) | .[] | reverse | join(" ")' |
	tr -d '"' >"$output"
