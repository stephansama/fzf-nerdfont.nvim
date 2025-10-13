--- @class FzfNerdFont.State
--- @field enabled? boolean
local FzfNerdState = { enabled = false }

--- Sets the state to its original value.
---
function FzfNerdState.new()
    local obj = setmetatable({}, { __index = FzfNerdState })
    obj.enabled = false
    return obj
end

return FzfNerdState
