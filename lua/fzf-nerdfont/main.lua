local fs = require("fzf-nerdfont.util.fs")
local log = require("fzf-nerdfont.util.log")
local config = require("fzf-nerdfont.config")
local unpack = unpack or table.unpack

--- @class FzfNerdFont.Main
local FzfNerdMain = {}

--- @param txt string
--- @param bufnr integer
--- @param win integer
local function insert_text(txt, bufnr, win)
    local row, col = unpack(vim.api.nvim_win_get_cursor(win))
    local line = unpack(vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false))
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
    if not selected or vim.tbl_isempty(selected) then
        return
    end

    for _, f in ipairs(selected) do
        insert_text(f, bufnr, win)
    end

    vim.cmd.quit({ bang = true })
end

--- Retrieve the location of the glyphs file.
---
--- @return string[]|nil
local function get_glyphs_file()
    local glyph_filename = fs.join_path({ config.options.glyphs_dir, "glyphnames" })
    if vim.fn.filereadable(glyph_filename) == 1 then
        return vim.fn.readfile(glyph_filename)
    end
end

--- Runs the fzf-lua command
---
function FzfNerdMain.run()
    local ok, fzf_lua = pcall(require, "fzf-lua")
    if not (ok and fzf_lua) then
        vim.notify("`fzf-lua` unavailable!", vim.log.levels.ERROR, { title = "FzfNerdFont" })
        return
    end

    local glyphs = get_glyphs_file()
    if not glyphs then
        vim.notify(
            "please regenerate the nerdfont glyphs file `:FzfNerdfont generate`",
            vim.log.levels.ERROR
        )
        return
    end

    log.debug("run", "fzf-nerdfont enabled")

    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()

    fzf_lua.fzf_exec(glyphs, {
        fzf_opts = { ["--multi"] = true },
        prompt = config.options.prompt,
        actions = {
            default = {
                function(selected) ---@param selected string[]
                    set_icon(selected, original_buf, original_win)
                end,
            },
        },
    })
end

--- Deletes the `glyphnames` file.
---
function FzfNerdMain.delete()
    local filename = fs.join_path({ config.options.glyphs_dir, "glyphnames" })
    if vim.fn.filereadable(filename) ~= 1 then
        vim.notify("Unable to find glyphs file", vim.log.levels.ERROR)
        return
    end

    if vim.fn.delete(filename) == 0 then
        vim.notify("Successfully deleted glyphs file.", vim.log.levels.INFO)
        return
    end

    vim.notify("Glyphs file could not be deleted!", vim.log.levels.ERROR)
end

--- Generates the `glyphnames` file.
---
function FzfNerdMain.generate()
    local current_path = debug.getinfo(1, "S").source:sub(2)
    local pattern = fs.join_path({ "^(.-)", "lua" })
    local root = current_path:match(pattern) --- @type string
    local script_path = fs.join_path({ root, "scripts", "update_glyphs.sh" })
    local code = vim.system(
        { "sh", "-c", script_path },
        { env = { GLYPHS_DIR = config.options.glyphs_dir } }
    )
        :wait().code

    if code == 0 then
        vim.notify("Successfully generated nerdfont glyphs", vim.log.levels.INFO)
        return
    end

    vim.notify("Failed to generate nerdfont glyphs!", vim.log.levels.ERROR)
end

return FzfNerdMain
