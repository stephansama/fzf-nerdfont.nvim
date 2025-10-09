---@class FzfNerdfont.Log
---@field enabled? boolean
local log = {}

local MAX_SCOPE = 15

--- prints only if debug is true.
---
---@param scope string: the scope from where this function is called.
---@param str string: the formatted string.
---@param ... any: the arguments of the formatted string.
function log.debug(scope, str, ...)
    return log.notify(scope, vim.log.levels.DEBUG, false, str, ...)
end

--- prints only if debug is true.
---
---@param scope string: the scope from where this function is called.
---@param level integer: the log level of vim.notify.
---@param verbose boolean: when false, only prints when config.debug is true.
---@param str string: the formatted string.
---@param ... any: the arguments of the formatted string.
function log.notify(scope, level, verbose, str, ...)
    if not (verbose and log.enabled) or vim.g.fzf_nerd_font_setup ~= 1 then
        return
    end

    if scope:len() > MAX_SCOPE then
        MAX_SCOPE = scope:len()
    end

    for i = MAX_SCOPE, scope:len(), -1 do
        local spc = i < scope:len() and " " or "" -- Conditionally set space char
        scope = ("%s%s"):format(scope, spc)
    end

    vim.notify(
        ("[fzf-nerdfont.nvim@%s] %s"):format(scope, str:format(...)),
        level,
        { title = "fzf-nerdfont.nvim" }
    )
end

--- analyzes the user provided `setup` parameters and sends a message if they use a deprecated option, then gives the new option to use.
---
---@param options table: the options provided by the user.
function log.warn_deprecation(options)
    local uses_deprecated_option = false
    local notice = "is now deprecated, use `%s` instead."
    local root_deprecated = {
        foo = "bar",
        bar = "baz",
    }

    for name, warning in pairs(root_deprecated) do
        if options[name] then
            uses_deprecated_option = true
            log.notify(
                "deprecated_options",
                vim.log.levels.WARN,
                true,
                ("`%s` %s"):format(name, (notice):format(warning))
            )
        end
    end

    if uses_deprecated_option then
        log.notify(
            "deprecated_options",
            vim.log.levels.WARN,
            true,
            "sorry to bother you with the breaking changes :("
        )
        log.notify(
            "deprecated_options",
            vim.log.levels.WARN,
            true,
            "use `:h FzfNerdfont.options` to read more."
        )
    end
end

return log
