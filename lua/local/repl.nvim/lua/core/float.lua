-- Module to deal with floating windows
local Float = {}
Float.__index = Float

-- Load some floating window utility functions
local float_config = require("utils.float").get_float_config_coords

-- Make Float() retrieve a new object
setmetatable(Float, {
    __call = function(cls)
        local self = setmetatable({}, cls)
        return self
    end,
})

-- Open the floating window
-- @returns [Float] Table containing the newly created table
function Float.open(self, X, Y, wp, hp, buffer, opts)

    -- If the floating window is opened, then just ignore this call
    if self.buffer ~= nil then
        vim.notify('Float is already opened. Ignoring', vim.log.levels.WARN)
        return
    end

    -- Buffer presented in the floating window
    self.buffer = buffer or vim.api.nvim_create_buf(false, true)

    -- Options defining the floating window
    local config = float_config(X, Y, wp, hp)
    opts = opts or {relative="editor", style="minimal"}
    self.config = vim.tbl_deep_extend("force", opts, config)

    -- Open a window
    self.window = vim.api.nvim_open_win(self.buffer, false, self.config)

    -- Set the window to visible
    self.is_visible = true
end

-- Close the floating window and whipe all the configuration
function Float.close(self)
    if not self:is_opened() then return end

    -- If the window is not visible, just close the buffer
    if self.is_visible then
        vim.api.nvim_win_close(self.window, true)
    else
        vim.api.nvim_buf_delete(self.buffer, {force=true})
    end

    -- Reset some of the contents of the floating window
    self.buffer     = nil
    self.config     = nil
    self.window     = nil
    self.is_visible = nil
end

-- Toggle the window. Do not close the buffer
function Float.toggle(self)
    if not self:is_opened() then return end

    if self.is_visible then
        vim.api.nvim_win_hide(self.window)
    else
        self.window = vim.api.nvim_open_win(self.buffer, false, self.config)
    end
    self.is_visible = not self.is_visible
end

-- Move the floating window vertically by one unit
-- @increment [bool] Boolean controlling movement: upwards or downwards
function Float.move_vertical(self, increment)
    if not self:is_opened() then return end
    self:update_config({
        row = self.config.row + (increment and -1 or 1),
        col = self.config.col,
    })
    vim.api.nvim_win_set_config(self.window, self.config)
end

-- Move the floating window horizontally by one unit
-- @increment [bool] Boolean controlling movement: right or left
function Float.move_horizontal(self, increment)
    if not self:is_opened() then return end
    self:update_config({
        row = self.config.row,
        col = self.config.col + (increment and 1 or -1),
    })
end

-- Resize the width of the window by one unit
-- @increment [bool] Boolean controlling resizing: increase or decrease
function Float.resize_width(self, increment)
    if not self:is_opened() then return end
    self:update_config({
        width = self.config.width + (increment and 1 or -1)
    })
end

-- Resize the width of the window by one unit
-- @increment [bool] Boolean controlling resizing: increase or decrease
function Float.resize_height(self, increment)
    if not self:is_opened() then return end
    self:update_config({
        height = self.config.height + (increment and -1 or 1)
    })
end

-- Helper methods {{{
function Float.is_opened(self)
    if not self.buffer then
        vim.notify('Float is not instantiated. Ignoring.', vim.log.levels.WARN)
        return false
    end
    return true
end

-- @config [table] Table containing the new config: 'help nvim_open_win'
function Float.update_config(self, config)
    self.config = vim.tbl_deep_extend("force", self.config, config)
    vim.api.nvim_win_set_config(self.window, self.config)
end
-- }}}

return Float
