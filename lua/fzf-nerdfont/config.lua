local log = require("fzf-nerdfont.util.log")

---@class FzfNerdFont.Config
local FzfNerdConfig = {}

--- `FzfNerdfont` options spec.
---
---@class FzfNerdFont.options
FzfNerdConfig.defaults = {
    -- Prints useful logs about what event are triggered
    -- and reasons for which actions are executed.
    ---@type boolean
    debug = false,
}

---@type FzfNerdFont.options
FzfNerdConfig.options = {}

--- Defines your `fzf-nerdfont` setup.
---
---@param options? FzfNerdFont.options Module config table. See |FzfNerdfont.options|.
function FzfNerdConfig.setup(options)
    options = options or {}
    FzfNerdConfig.options = vim.tbl_deep_extend("keep", options, FzfNerdConfig.defaults)

    log.enabled = FzfNerdConfig.options.debug
    log.warn_deprecation(FzfNerdConfig.options)

    vim.g.fzf_nerd_font_setup = 1
end

return FzfNerdConfig
