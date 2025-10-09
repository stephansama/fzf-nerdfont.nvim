local log = require("fzf-nerdfont.util.log")
local state = require("fzf-nerdfont.state")

-- internal methods
---@class FzfNerdFont.Main
local Main = {}

---@param selected string[]
local function set_icon(selected)
    local _unpack = unpack or table.unpack

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()

    for _, f in ipairs(selected) do
        local row, col = _unpack(vim.api.nvim_win_get_cursor(original_win)) -- Get current cursor position
        local icon = f:match("^(%S+)")
        local line = _unpack(vim.api.nvim_buf_get_lines(original_buf, row - 1, row, false))
        local text = line:sub(1, col) .. icon .. line:sub(col + 1)
        local new_line = { text }
        vim.api.nvim_buf_set_lines(original_buf, row - 1, row, true, new_line)
        vim.api.nvim_win_set_cursor(original_win, { row, col })
    end
    vim.cmd.quit({ bang = true })
end

--- Initializes the plugin, sets event listeners and internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.run(scope)
    scope = scope or ""
    if state.enabled then
        log.debug(scope, "fzf-nerdfont is already enabled")
        return
    end

    local script_path = debug.getinfo(1, "S").source:sub(2)
    local script_dir = vim.fn.fnamemodify(script_path, ":h")
    -- TODO: (DrKJeff16) Need a better file location
    local glyphs = vim.fn.readfile(script_dir .. "/glyphnames")

    state.enabled = true
    log.debug(scope, "fzf-nerdfont enabled")

    require("fzf-lua").fzf_exec(glyphs, {
        fzf_opts = { ["--multi"] = true },
        prompt = "Select Icon>",
        actions = {
            default = { set_icon },
        },
    })
end

return Main
