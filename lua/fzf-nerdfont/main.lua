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
---@param bufnr integer
---@param win integer
local function set_icon(selected, bufnr, win)
    for _, f in ipairs(selected) do
        insert_text(f, bufnr, win)
    end
    vim.cmd.quit({ bang = true })
end

local function get_glyphs_file()
    local glyph_filename = vim.fn.stdpath("data") .. "/glyphnames"

    if vim.fn.filereadable(glyph_filename) == 1 then
        return vim.fn.readfile(glyph_filename)
    end
end

--- Initializes the plugin, sets event listeners and internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.run(scope)
    scope = scope or ""

    local glyphs = get_glyphs_file()

    if not glyphs then
        return vim.notify(
            "please regenerate nerdfont glyph file with :FzfNerdfont generate",
            vim.log.levels.WARN
        )
    end

    log.debug(scope, "fzf-nerdfont enabled")

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()

    local ok, fzf_lua = pcall(require, "fzf-lua")

    if not ok or not fzf_lua then
        return vim.notify("not able to load fzf-lua", vim.log.levels.ERROR)
    end

    fzf_lua.fzf_exec(glyphs, {
        fzf_opts = { ["--multi"] = true },
        prompt = "Select Icon>",
        actions = {
            default = {
                function(selected)
                    set_icon(selected, original_buf, original_win)
                end,
            },
        },
    })
end

function Main.generate()
    local current_path = debug.getinfo(1, "S").source:sub(2)
    local root = current_path:match("^(.-)/lua")
    local script_path = root .. "/scripts/update_glyphs.sh"

    local generate_glyph = vim.system({ "sh", "-c", script_path }):wait()

    if generate_glyph.code ~= 0 then
        vim.notify("Failed to generate nerdfont glyphs", vim.log.levels.ERROR)
    else
        vim.notify("Successfully generated nerdfont glyphs", vim.log.levels.INFO)
    end
end

return Main
