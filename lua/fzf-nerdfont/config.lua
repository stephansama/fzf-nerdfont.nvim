local log = require("fzf-nerdfont.util.log")

--- @class FzfNerdFont.Config
local FzfNerdConfig = {}

--- `FzfNerdfont` options spec.
---
--- @class FzfNerdFont.options
FzfNerdConfig.defaults = {
    --- Prints useful logs about what event are triggered
    --- and reasons for which actions are executed.
    ---
    --- @type boolean
    debug = false,

    --- Sets the location in which the `glyphnames` file will
    --- be saved at.
    ---
    --- @type string
    glyphs_dir = vim.fn.stdpath("data"),
}

--- @type FzfNerdFont.options
FzfNerdConfig.options = {}

--- Defines your `fzf-nerdfont` setup.
---
--- @param options? FzfNerdFont.options Module config table. See |FzfNerdfont.options|.
function FzfNerdConfig.setup(options)
    FzfNerdConfig.options = vim.tbl_deep_extend("keep", options or {}, FzfNerdConfig.defaults)

    if vim.fn.isdirectory(FzfNerdConfig.options.glyphs_dir) ~= 1 then
        vim.notify(
            ("`%s` is not a valid directory. Reverting back to the default."):format(
                FzfNerdConfig.options.glyphs_dir
            )
        )

        FzfNerdConfig.options.glyphs_dir = FzfNerdConfig.defaults.glyphs_dir
    end

    log.enabled = FzfNerdConfig.options.debug
    log.warn_deprecation(FzfNerdConfig.options)

    _G.FzfNerdfont.config = FzfNerdConfig.options

    vim.g.fzf_nerd_font_setup = 1
end

return FzfNerdConfig
