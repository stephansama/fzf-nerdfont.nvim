if vim.g.fzf_nerd_font_loaded == 1 then
    return
end

vim.g.fzf_nerd_font_loaded = 1

local generate_completions = function()
    local completions = {}

    for key, _ in pairs(require("fzf-nerdfont.main")) do
        completions[#completions + 1] = key
    end

    return completions
end

vim.api.nvim_create_user_command("FzfNerdfont", function(ctx)
    local fzf_nerdfont = require("fzf-nerdfont")
    local selected = fzf_nerdfont[ctx.args]

    if selected ~= nil then
        return selected()
    end

    fzf_nerdfont.run()
end, { nargs = "?", complete = generate_completions })
