local log = require("fzf-nerdfont.util.log")

local FzfNerdfont = {}

--- FzfNerdfont configuration with its default values.
---
---@type table
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
FzfNerdfont.options = {
    -- Prints useful logs about what event are triggered, and reasons actions are executed.
    debug = false,
}

---@private
local defaults = vim.deepcopy(FzfNerdfont.options)

--- Defaults FzfNerdfont options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |FzfNerdfont.options|.
---
---@private
function FzfNerdfont.defaults(options)
    FzfNerdfont.options =
        vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    -- let your user know that they provided a wrong value, this is reported when your plugin is executed.
    assert(
        type(FzfNerdfont.options.debug) == "boolean",
        "`debug` must be a boolean (`true` or `false`)."
    )

    return FzfNerdfont.options
end

--- Define your fzf-nerdfont setup.
---
---@param options table Module config table. See |FzfNerdfont.options|.
---
---@usage `require("fzf-nerdfont").setup()` (add `{}` with your |FzfNerdfont.options| table)
function FzfNerdfont.setup(options)
    FzfNerdfont.options = FzfNerdfont.defaults(options or {})

    log.warn_deprecation(FzfNerdfont.options)

    return FzfNerdfont.options
end

return FzfNerdfont
