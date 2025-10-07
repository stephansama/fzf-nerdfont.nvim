local log = require("fzf-nerdfont.util.log")
local state = require("fzf-nerdfont.state")

-- internal methods
---@class FzfNerdFont.Main
local Main = {}

-- Toggle the plugin by calling the `enable`/`disable` methods respectively.
--
---@param scope? string: internal identifier for logging purposes.
function Main.toggle(scope)
    scope = scope or ''
    if state.enabled then
        Main.disable(scope)
        return
    end
    Main.enable(scope)
end

--- Initializes the plugin, sets event listeners and internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.enable(scope)
    scope = scope or ''
    if state.enabled then
        log.debug(scope, "fzf-nerdfont is already enabled")
        return
    end

    local script_path = debug.getinfo(1, "S").source:sub(2)
    local script_dir = vim.fn.fnamemodify(script_path, ":h")
    -- (DrKJeff16): Need a better file location
    local glyphs = vim.fn.readfile(script_dir .. "/glyphnames")

    state.enabled = true
    log.debug(scope, "fzf-nerdfont enabled")

    require("fzf-lua").fzf_exec(glyphs, {
        fzf_opts = { ["--multi"] = true },
        actions = {
            default = {
                function(selected) ---@param selected string[]
                    vim.cmd.quit({ bang = true })
                    for _, f in ipairs(selected) do
                        local icon = f:match("^(%S+)")
                        local row, col = unpack(vim.api.nvim_win_get_cursor(0)) -- Get current cursor position
                        row = row - 1 -- API is 0-indexed

                        local line = vim.api.nvim_get_current_line()
                        local new_line = line:sub(1, col) .. icon .. line:sub(col + 1)
                        vim.api.nvim_set_current_line(new_line)
                        vim.api.nvim_win_set_cursor(0, { row + 1, col + #icon })
                    end
                end,
            },
        },
        prompt = "Select Icon>",
    })
end

--- Disables the plugin for the given tab, clear highlight groups and autocmds,
--- closes side buffers and resets the internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.disable(scope)
    scope = scope or ''
    if not state.enabled then
        log.debug(scope, "fzf-nerdfont is already disabled")
        return
    end

    state.enabled = false
    log.debug(scope, "fzf-nerdfont disabled")
end

return Main
