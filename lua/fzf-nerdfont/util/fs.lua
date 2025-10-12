local fs = {}

--- @return "\\"|"/"
function fs.get_separator()
    return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- @param path string[]
function fs.join_path(path)
    return table.concat(path, fs.get_separator())
end

return fs
