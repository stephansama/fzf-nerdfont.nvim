local log = require("fzf-nerdfont.util.log")

--- The `fzf-nerdfont.config` module.
---
--- It provides the `setup()` function for the plugin,
--- aswell as storing the config options for the plugin.
---
--- @class FzfNerdFont.Config
local FzfNerdConfig = {}

--- @class FzfNerdFontOpts
local defaults = {
    --- Prints useful logs about what events are triggered.
    --- @type boolean
    debug = false,
    --- Sets the location in which the `glyphnames` file will be saved at.
    --- @type string
    glyphs_dir = require("fzf-nerdfont.util.fs").join_path({
        vim.fn.stdpath("data"),
        "fzf-nerdfont",
    }),
    --- Sets the prompt used for the fzf-lua command
    --- @type string
    prompt = "Select Icon>",
}

--- The config options for `fzf-nerdfont.nvim`.
---
--- @class FzfNerdFontOpts
FzfNerdConfig.options = {}

--- Defines your `fzf-nerdfont` setup.
---
--- @param options? FzfNerdFontOpts Module config table. See |FzfNerdfont.options|.
function FzfNerdConfig.setup(options)
    FzfNerdConfig.options = vim.tbl_deep_extend("keep", options or {}, defaults)

    vim.fn.mkdir(FzfNerdConfig.options.glyphs_dir, "p")

    log.enabled = FzfNerdConfig.options.debug
    log.warn_deprecation(FzfNerdConfig.options)

    _G.FzfNerdfont.config = FzfNerdConfig.options

    vim.g.fzf_nerd_font_setup = 1
end

return FzfNerdConfig
