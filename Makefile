DEPS_CMD = ./scripts/deps.sh

NVIM_CMD = nvim --headless --noplugin -u ./scripts/minimal_init.lua

MINI_TEST_CMD = $(NVIM_CMD) \
				-c "lua require('mini.test').setup()" \
				-c "lua MiniTest.run({ execute = { reporter = MiniTest.gen_reporter.stdout({ group_depth = 2 }) } })"

MINI_DOC_CMD = $(NVIM_CMD) \
			   -c "lua require('mini.doc').generate()" \
			   -c "qa!"

.POSIX:

.SUFFIXES:

.PHONY: all clean test-nightly test-0.8.3 test documentation lint luals update_glyphs setup ensure-deps/mini ensure-deps/luals

all: documentation lint luals test

# Make sure LuaLS deps are installed
ensure-deps/luals:
	@$(DEPS_CMD) luals

# Make sure mini.test deps are installed
ensure-deps/mini:
	@$(DEPS_CMD) mini

# runs all the test files.
test: ensure-deps/mini
	@nvim --version | head -n 1
	@$(MINI_TEST_CMD)

# runs all the test files on the nightly version, `bob` must be installed.
test-nightly: ensure-deps/mini
	@bob use nightly
	@$(MAKE) test

# runs all the test files on the 0.8.3 version, `bob` must be installed.
test-0.8.3: ensure-deps/mini
	@bob use 0.8.3
	@$(MAKE) test

# cleans the `deps/` and `.ci/` directories, useful for resetting the environment.
clean:
	@rm -rf deps .ci

# installs deps, then generates documentation.
documentation: ensure-deps/mini
	@$(MINI_DOC_CMD)

# performs a lint check and fixes issue if possible, following the config in `stylua.toml`.
lint:
	@stylua . -g '*.lua' -g '!deps/' -g '!nightly/'
	@selene plugin/ lua/

luals: ensure-deps/luals
	@lua-language-server --configpath .luarc.json --logpath .ci/lua-ls/log --check .
	@[ -f .ci/lua-ls/log/check.json ] && { cat .ci/lua-ls/log/check.json 2>/dev/null; exit 1; } || true

update_glyphs:
	@./scripts/update_glyphs.sh

# setup
setup:
	@./scripts/setup.sh
