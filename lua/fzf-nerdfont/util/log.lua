--- Provides logging utilities, built specifically for `fzf-nerdfont.nvim`.
---
--- @class FzfNerdfont.Log
--- @field enabled? boolean
local FzfNerdLog = {}

local MAX_SCOPE = 15

--- Runs only if `debug` is enabled.
---
--- @param scope string: the scope from where this function is called.
--- @param str string: the formatted string.
--- @param ... any: any extra arguments for the formatted string.
function FzfNerdLog.debug(scope, str, ...)
    return FzfNerdLog.notify(scope, vim.log.levels.DEBUG, false, str, ...)
end

--- Notifies the user.
--- Runs only if `debug` is enabled.
---
--- @param scope string: the scope from where this function is called.
--- @param level integer: the log level of vim.notify.
--- @param verbose boolean: when disabled it will only print if `config.debug` is `true`.
--- @param str string: the formatted string.
--- @param ... any: any extra arguments for the formatted string.
function FzfNerdLog.notify(scope, level, verbose, str, ...)
    if not (verbose and FzfNerdLog.enabled) or vim.g.fzf_nerd_font_setup ~= 1 then
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

--- Analyzes the user's provided config parameters and will
--- send a message if any of them use a deprecated option,
--- then give the new option to use.
---
--- @param options FzfNerdFontOpts: the options provided by the user.
function FzfNerdLog.warn_deprecation(options)
    local uses_deprecated_option = false
    local notice = "is now deprecated, use `%s` instead."
    local root_deprecated = { foo = "bar", bar = "baz" }

    for name, warning in pairs(root_deprecated) do
        if options[name] then
            uses_deprecated_option = true
            FzfNerdLog.notify(
                "deprecated_options",
                vim.log.levels.WARN,
                true,
                ("`%s` %s"):format(name, (notice):format(warning))
            )
        end
    end

    if uses_deprecated_option then
        -- FzfNerdLog.notify(
        --     "deprecated_options",
        --     vim.log.levels.WARN,
        --     true,
        --     "sorry to bother you with the breaking changes :("
        -- )
        FzfNerdLog.notify(
            "deprecated_options",
            vim.log.levels.WARN,
            true,
            "use `:h FzfNerdfont.options` to read more."
        )
    end
end

return FzfNerdLog
