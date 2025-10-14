--- @class FzfNerdFont.State
local FzfNerdState = { enabled = false }

--- Generates a new `state`.
---
function FzfNerdState.new()
    local obj = setmetatable({}, { __index = FzfNerdState }) ---@type FzfNerdFont.State
    obj.enabled = false
    return obj
end

return FzfNerdState
