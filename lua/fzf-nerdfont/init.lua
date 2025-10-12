local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

--- @class FzfNerdFont : FzfNerdFont.Main
local FzfNerdFont = {}

FzfNerdFont.setup = config.setup

for key, func in pairs(main) do
    FzfNerdFont[key] = function()
        if vim.g.fzf_nerd_font_setup ~= 1 then
            config.setup()
        end

        func()
    end
end

--- @class FzfNerdFont
_G.FzfNerdfont = FzfNerdFont

return FzfNerdFont
