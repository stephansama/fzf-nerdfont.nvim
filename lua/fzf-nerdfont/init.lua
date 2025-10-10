local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

---@class FzfNerdFont
local FzfNerdFont = {}

-- setup FzfNerdFont options and merge them with user provided ones.
FzfNerdFont.setup = config.setup

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function FzfNerdFont.run()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        FzfNerdFont.setup()
    end

    main.run("public_api_toggle")
end

function FzfNerdFont.generate()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        FzfNerdFont.setup()
    end

    main.generate()
end

---@class table
_G.FzfNerdfont = FzfNerdFont

return FzfNerdFont
