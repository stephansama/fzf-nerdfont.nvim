-- You can use this loaded variable to enable conditional parts of your plugin.
if vim.g.fzf_nerd_font_loaded == 1 then
    return
end

vim.g.fzf_nerd_font_loaded = 1

vim.api.nvim_create_user_command("FzfNerdfont", function()
    require("fzf-nerdfont").run()
end, {})
