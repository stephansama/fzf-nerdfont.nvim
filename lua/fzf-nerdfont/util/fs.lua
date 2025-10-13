--- @class FzfNerdfont.fs
local FzfNerdFS = {}

--- @return "\\"|"/"
function FzfNerdFS.get_separator()
    return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- @param path string[]
function FzfNerdFS.join_path(path)
    return table.concat(path, FzfNerdFS.get_separator())
end

return FzfNerdFS
