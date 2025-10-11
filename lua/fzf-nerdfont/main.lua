local log = require("fzf-nerdfont.util.log")
local config = require("fzf-nerdfont.config")

--- @class FzfNerdFont.Main
local Main = {}

local _unpack = unpack or table.unpack

--- Set the path separator depending on whether the user's in a Windows OS or not.
---
--- @return "\\"|"/"
local function get_separator()
    return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- @param path string[]
--- @return string str
local function join_path(path)
    local sep = get_separator()
    local str = ""
    for i, val in ipairs(path) do
        str = i == 1 and val or (str .. sep .. val)
    end

    return str
end

--- @param txt string
--- @param bufnr integer
--- @param win integer
local function insert_text(txt, bufnr, win)
    local row, col = _unpack(vim.api.nvim_win_get_cursor(win))
    local line = _unpack(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false))
    local icon = txt:match("^(%S+)")
    local text = line:sub(1, col) .. icon .. line:sub(col + 1)
    local new_line = { text }
    vim.api.nvim_buf_set_lines(bufnr, row - 1, row, true, new_line)
    vim.api.nvim_win_set_cursor(win, { row, col })
end

--- Sets the icon in the target buffer.
---
--- @param selected string[]
--- @param bufnr integer
--- @param win integer
local function set_icon(selected, bufnr, win)
    for _, f in ipairs(selected) do
        insert_text(f, bufnr, win)
    end
    vim.cmd.quit({ bang = true })
end

--- Retrieve the location of the glyphs file.
---
--- @return string[]|nil
local function get_glyphs_file()
    local glyph_filename = join_path({ config.options.glyphs_dir, "glyphnames" })
    if vim.fn.filereadable(glyph_filename) == 1 then
        return vim.fn.readfile(glyph_filename)
    end
end

--- Initializes the plugin, sets event listeners and internal state.
---
--- @param scope? string: internal identifier for logging purposes.
function Main.run(scope)
    scope = scope or ""

    local ok, fzf_lua = pcall(require, "fzf-lua")
    if not (ok and fzf_lua) then
        error("`fzf-lua` unavailable!", vim.log.levels.ERROR)
    end

    local glyphs = get_glyphs_file()
    if not glyphs then
        vim.notify(
            "you must regenerate the nerdfont glyphs file `:FzfNerdfont generate`",
            vim.log.levels.WARN
        )
        return
    end

    log.debug(scope, "fzf-nerdfont enabled")

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()

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

--- Generates the `glyphnames` file.
---
function Main.generate()
    local current_path = debug.getinfo(1, "S").source:sub(2)
    local pattern = join_path({ "^(.-)", "lua" })
    local root = current_path:match(pattern) --- @type string
    local script_path = join_path({ root, "scripts", "update_glyphs.sh" })
    local code = vim.system({ "sh", "-c", script_path }):wait().code

    if code == 0 then
        vim.notify("Successfully generated nerdfont glyphs", vim.log.levels.INFO)
        return
    end

    error("Failed to generate nerdfont glyphs", vim.log.levels.ERROR)
end

return Main
