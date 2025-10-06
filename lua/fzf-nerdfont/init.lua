local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

local FzfNerdfont = {}

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function FzfNerdfont.toggle()
    if _G.FzfNerdfont.config == nil then
        _G.FzfNerdfont.config = config.options
    end

    local glyphs =
        vim.fn.readfile(vim.fn.expand("~") .. "/Code/nvim-plugins/fzf-nerdfont.nvim/glyphnames")

    local fzf_lua = require("fzf-lua")

    fzf_lua.fzf_exec(glyphs, {
        fzf_opts = {
            ["--multi"] = true,
        },
        actions = {
            ["default"] = {
                function(selected)
                    -- close fzf-lua
                    vim.cmd([[q!]])

                    for _, f in ipairs(selected) do
                        local icon = f:match("^(%S+)")
                        -- Get current cursor position
                        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                        row = row - 1 -- API is 0-indexed

                        -- Get the current line contents
                        local line = vim.api.nvim_get_current_line()

                        -- Insert text at cursor position
                        local new_line = line:sub(1, col) .. icon .. line:sub(col + 1)

                        -- Replace line with new version
                        vim.api.nvim_set_current_line(new_line)

                        -- Move cursor to end of inserted text
                        vim.api.nvim_win_set_cursor(0, { row + 1, col + #icon })
                    end
                end,
            },
        },
        prompt = "Select Icon>",
    })

    -- main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
function FzfNerdfont.enable(scope)
    if _G.FzfNerdfont.config == nil then
        _G.FzfNerdfont.config = config.options
    end

    main.toggle(scope or "public_api_enable")
end

--- Disables the plugin, clear highlight groups and autocmds, closes side buffers and resets the internal state.
function FzfNerdfont.disable()
    main.toggle("public_api_disable")
end

-- setup FzfNerdfont options and merge them with user provided ones.
function FzfNerdfont.setup(opts)
    _G.FzfNerdfont.config = config.setup(opts)
end

_G.FzfNerdfont = FzfNerdfont

return _G.FzfNerdfont
