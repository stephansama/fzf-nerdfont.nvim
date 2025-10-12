if vim.g.fzf_nerd_font_loaded == 1 then
    return
end

vim.g.fzf_nerd_font_loaded = 1

local completions

local generate_completions = function()
    if not completions then
        completions = {}
        for key, _ in pairs(require("fzf-nerdfont.main")) do
            completions[#completions + 1] = key
        end
    end

    return completions
end

vim.api.nvim_create_user_command("FzfNerdfont", function(ctx)
    local fzf_nerdfont = require("fzf-nerdfont")
    local selected = fzf_nerdfont[ctx.args]

    if ctx.args == "" then
        return fzf_nerdfont.run()
    end

    if selected ~= nil then
        return selected()
    else
        vim.notify(("Invalid argument: '%s'"):format(ctx.args), vim.log.levels.ERROR)
    end
end, { nargs = "?", complete = generate_completions })
