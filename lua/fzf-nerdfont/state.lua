---@class FzfNerdFont.State
---@field enabled? boolean
local state = { enabled = false }

---Sets the state to its original value.
---
function state.new()
    local obj = setmetatable({}, { __index = state })
    obj.enabled = false
    return obj
end

return state
