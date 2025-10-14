if vim.g.fzf_nerd_font_loaded == 1 then
    return
end

vim.g.fzf_nerd_font_loaded = 1

local function generate_completions()
    local main = require("fzf-nerdfont.main")
    local completions = vim.tbl_keys(main)
    return completions
end

vim.api.nvim_create_user_command("FzfNerdfont", function(ctx)
    local fzf_nerdfont = require("fzf-nerdfont")
    if ctx.args == "" then
        fzf_nerdfont.run()
        return
    end

    local selected = fzf_nerdfont[ctx.args]
    if selected ~= nil then
        selected()
        return
    end

    vim.notify(("Invalid argument: '%s'"):format(ctx.args), vim.log.levels.ERROR)
end, { nargs = "?", complete = generate_completions })
