local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

---@class FzfNerdFont
local FzfNerdFont = {}

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function FzfNerdFont.toggle()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        return
    end

    main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
---@param scope? string
function FzfNerdFont.enable(scope)
    if vim.g.fzf_nerd_font_setup ~= 1 then
        return
    end
    scope = scope or "public_api_enable"
    main.enable(scope)
end

--- Disables the plugin, clear highlight groups and autocmds,
--- closes side buffers and resets the internal state.
function FzfNerdFont.disable()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        return
    end
    main.disable("public_api_disable")
end

-- setup FzfNerdFont options and merge them with user provided ones.
FzfNerdFont.setup = config.setup

return FzfNerdFont
