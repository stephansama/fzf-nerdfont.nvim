local log = require("fzf-nerdfont.util.log")
local fs = require("fzf-nerdfont.util.fs")

--- @class FzfNerdFont.Config
local FzfNerdConfig = {}

---@class FzfNerdFontOpts
---@field debug boolean Prints useful logs about what events are triggered
---@field glyphs_dir string Sets the location in which the `glyphnames` file will be saved at.
---@field prompt string Sets the prompt used for the fzf-lua command

--- @class FzfNerdFontOpts
FzfNerdConfig.defaults = {
    debug = false,
    glyphs_dir = fs.join_path({ vim.fn.stdpath("data"), "fzf-nerdfont" }),
    prompt = "Select Icon>",
}

--- @class FzfNerdFontOpts
FzfNerdConfig.options = {}

--- Defines your `fzf-nerdfont` setup.
---
--- @param options? FzfNerdFontOpts Module config table. See |FzfNerdfont.options|.
function FzfNerdConfig.setup(options)
    FzfNerdConfig.options = vim.tbl_deep_extend("keep", options or {}, FzfNerdConfig.defaults)

    vim.fn.mkdir(FzfNerdConfig.options.glyphs_dir, "p")

    log.enabled = FzfNerdConfig.options.debug
    log.warn_deprecation(FzfNerdConfig.options)

    _G.FzfNerdfont.config = FzfNerdConfig.options

    vim.g.fzf_nerd_font_setup = 1
end

return FzfNerdConfig
