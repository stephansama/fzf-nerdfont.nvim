local log = require("fzf-nerdfont.util.log")

-- internal methods
---@class FzfNerdFont.Main
local Main = {}

local _unpack = unpack or table.unpack

---@param txt string
---@param bufnr integer
---@param win integer
local function insert_text(txt, bufnr, win)
    local row, col = _unpack(vim.api.nvim_win_get_cursor(win)) -- Get current cursor position
    local line = _unpack(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false))
    local icon = txt:match("^(%S+)")
    local text = line:sub(1, col) .. icon .. line:sub(col + 1)
    local new_line = { text }
    vim.api.nvim_buf_set_lines(bufnr, row - 1, row, true, new_line)
    vim.api.nvim_win_set_cursor(win, { row, col })
end

---@param selected string[]
local function set_icon(selected, bufnr, win)
    for _, f in ipairs(selected) do
        insert_text(f, bufnr, win)
    end
    vim.cmd.quit({ bang = true })
end

--- Initializes the plugin, sets event listeners and internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.run(scope)
    scope = scope or ""

    local script_path = debug.getinfo(1, "S").source:sub(2)
    local script_dir = vim.fn.fnamemodify(script_path, ":h")
    -- TODO: (DrKJeff16) Need a better file location
    local glyphs = vim.fn.readfile(script_dir .. "/glyphnames")

    log.debug(scope, "fzf-nerdfont enabled")

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()
    require("fzf-lua").fzf_exec(glyphs, {
        fzf_opts = { ["--multi"] = true },
        prompt = "Select Icon>",
        actions = {
            default = { function(selected)
                set_icon(selected, original_buf, original_win)
            end,
        }
        },
    })
end

return Main
