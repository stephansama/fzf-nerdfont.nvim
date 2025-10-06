local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

local FzfNerdfont = {}

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function FzfNerdfont.toggle()
    if _G.FzfNerdfont.config == nil then
        _G.FzfNerdfont.config = config.options
    end

    main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
function FzfNerdfont.enable(scope)
    if _G.FzfNerdfont.config == nil then
        _G.FzfNerdfont.config = config.options
    end

    main.toggle(scope or "public_api_enable")
end

--- Disables the plugin, clear highlight groups and autocmds, closes side buffers and resets the internal state.
function FzfNerdfont.disable()
    main.toggle("public_api_disable")
end

-- setup FzfNerdfont options and merge them with user provided ones.
function FzfNerdfont.setup(opts)
    _G.FzfNerdfont.config = config.setup(opts)
end

_G.FzfNerdfont = FzfNerdfont

return _G.FzfNerdfont
