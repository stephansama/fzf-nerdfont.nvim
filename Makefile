.POSIX:

.SUFFIXES:

.PHONY: all clean deps deps/mini deps/luals test-nightly test-0.8.3 test documentation lint luals update_glyphs setup

all: documentation lint luals test

deps: deps/mini deps/luals

# installs `mini.nvim`.
deps/mini:
	./scripts/deps.sh mini

# installs `LuaLS`.
deps/luals:
	./scripts/deps.sh luals

# runs all the test files.
test: deps/mini
	nvim --version | head -n 1 && echo ''
	nvim --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.test').setup()" \
		-c "lua MiniTest.run({ execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }) } })"

# runs all the test files on the nightly version, `bob` must be installed.
test-nightly:
	bob use nightly
	$(MAKE) test

# runs all the test files on the 0.8.3 version, `bob` must be installed.
test-0.8.3:
	bob use 0.8.3
	$(MAKE) test

# cleans the `deps/` and `.ci/` directories, useful for resetting the environment.
clean:
	rm -rf deps .ci

# installs deps, then generates documentation.
documentation: deps/mini
	nvim --headless --noplugin -u ./scripts/minimal_init.lua \
		-c "lua require('mini.doc').generate()" \
		-c "qa!"

# performs a lint check and fixes issue if possible, following the config in `stylua.toml`.
lint:
	stylua . -g '*.lua' -g '!deps/' -g '!nightly/'
	selene plugin/ lua/

luals: deps/luals
	lua-language-server --configpath .luarc.json --logpath .ci/lua-ls/log --check .
	[ -f .ci/lua-ls/log/check.json ] && { cat .ci/lua-ls/log/check.json 2>/dev/null; exit 1; } || true

update_glyphs:
	./scripts/update_glyphs.sh

# setup
setup:
	./scripts/setup.sh
