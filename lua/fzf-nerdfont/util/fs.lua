--- Filesystem utilities for `fzf-nerdfont.nvim`.
---
--- @class FzfNerdfont.fs
local FzfNerdFS = {}

--- Generates the appropriate path separator
--- for the user's OS.
---
---  - `"/"`: UNIX systems
---  - `"\"`: Windows systems
---
--- @return "\\"|"/" sep: the resolved separator.
function FzfNerdFS.get_separator()
    return vim.fn.has("win32") == 1 and "\\" or "/"
end

--- Given a list of strings, returns a path-like string,
--- with the platform-appropriate path separators.
---
--- @param path string[]: the path to be processed, converted into a list.
--- @return string new_path: the processed path string.
function FzfNerdFS.join_path(path)
    --- TODO: Account for empty tables.
    return table.concat(path, FzfNerdFS.get_separator())
end

return FzfNerdFS
