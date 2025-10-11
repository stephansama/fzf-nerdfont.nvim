if vim.g.fzf_nerd_font_loaded == 1 then
    return
end

vim.g.fzf_nerd_font_loaded = 1

vim.api.nvim_create_user_command("FzfNerdfont", function(ctx)
    if ctx.args == "generate" then
        require("fzf-nerdfont").generate()
        return
    end

    require("fzf-nerdfont").run()
end, {
    nargs = "?",
    complete = function()
        return { "generate" }
    end,
})
