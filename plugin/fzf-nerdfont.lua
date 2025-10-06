-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.FzfNerdfontLoaded then
    return
end

_G.FzfNerdfontLoaded = true

vim.api.nvim_create_user_command("FzfNerdfont", function()
    require("fzf-nerdfont").toggle()
end, {})
