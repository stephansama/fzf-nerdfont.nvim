#!/bin/bash

[[ $# -eq 0 ]] && exit 127

DEP="$1"
LUALS_URL="https://github.com/LuaLS/lua-language-server/releases/download/3.7.4/lua-language-server-3.7.4-darwin-x64.tar.gz"

__get_mini() {
    if ! [ -d ./deps/mini.nvim ]; then
        printf "git clone --depth 1 https://github.com/nvim-mini/mini.nvim deps/mini.nvim\n"
        git clone --depth 1 https://github.com/nvim-mini/mini.nvim deps/mini.nvim
    fi
    return 0
}

__get_lua_ls() {
    if [[ -d .ci/lua-ls ]]; then
        printf "rm -rf .ci/lua-ls/log\n"
        rm -rf .ci/lua-ls/log
        return 0
    fi

	printf "%s\n" "mkdir -p .ci/lua-ls" "curl -sL \"\$LUALS_URL\" | tar xzf - -C \"\$(pwd)/.ci/lua-ls\""

    mkdir -p .ci/lua-ls
    curl -sL "$LUALS_URL" | tar xzf - -C "$(pwd)/.ci/lua-ls"

    return $?
}

case "$DEP" in
    [Mm][Ii][Nn][Ii]) __get_mini; exit $? ;;
    [Ll][Uu][Aa][Ll][Ss]) __get_lua_ls; exit $? ;;
    *) exit 1 ;;
esac
