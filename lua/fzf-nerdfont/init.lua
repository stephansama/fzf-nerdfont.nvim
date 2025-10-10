local main = require("fzf-nerdfont.main")
local config = require("fzf-nerdfont.config")

---@class FzfNerdFont
local FzfNerdFont = {}

FzfNerdFont.setup = config.setup

function FzfNerdFont.run()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        config.setup()
    end

    main.run("public_api_toggle")
end

function FzfNerdFont.generate()
    if vim.g.fzf_nerd_font_setup ~= 1 then
        config.setup()
    end

    main.generate()
end

---@class FzfNerdFont
_G.FzfNerdfont = FzfNerdFont

return FzfNerdFont
