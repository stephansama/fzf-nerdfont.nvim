.POSIX:

.SUFFIXES:

.PHONY: all clean deps test-nightly test-0.8.3 test documentation lint luals update_glyphs setup

all: documentation lint luals test

deps: deps/mini deps/luals

# installs `mini.nvim` and LuaLS.
deps/mini:
	./scripts/deps.sh mini

deps/luals:
	./scripts/deps.sh luals

# runs all the test files.
test: deps
	nvim --version | head -n 1 && echo ''
	nvim --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.test').setup()" \
		-c "lua MiniTest.run({ execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }) } })"

# runs all the test files on the nightly version, `bob` must be installed.
test-nightly: deps
	bob use nightly
	make test

# runs all the test files on the 0.8.3 version, `bob` must be installed.
test-0.8.3: deps
	bob use 0.8.3
	make test

# cleans the `deps/` directory, useful for resetting the environment.
clean:
	rm -rf deps

# installs deps, then generates documentation.
documentation: deps
	nvim --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.doc').generate()" \
		-c "qa!"

# performs a lint check and fixes issue if possible, following the config in `stylua.toml`.
lint:
	stylua . -g '*.lua' -g '!deps/' -g '!nightly/'
	selene plugin/ lua/

luals: deps
	lua-language-server --configpath .luarc.json --logpath .ci/lua-ls/log --check .
	[ -f .ci/lua-ls/log/check.json ] && { cat .ci/lua-ls/log/check.json 2>/dev/null; exit 1; } || true

update_glyphs:
	./scripts/update_glyphs.sh

# setup
setup:
	./scripts/setup.sh
