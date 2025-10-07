---@class FzfNerdFont.State
---@field enabled? boolean
local state = {}

---Sets the state to its original value.
---
function state:new()
    self.__index = self
    local obj = setmetatable({}, self)
    obj.enabled = false

    return obj
end

return state
