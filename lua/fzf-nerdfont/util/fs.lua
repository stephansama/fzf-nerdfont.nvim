local M = {}

--- @return "\\"|"/"
M.get_separator = function()
    return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- @param path string[]
M.join_path = function(path)
    local sep = M.get_separator()
    local str = ""

    for index, curr in ipairs(path) do
        if index == 1 then
            str = curr
        else
            str = str .. sep .. curr
        end
    end

    return str
end

return M
