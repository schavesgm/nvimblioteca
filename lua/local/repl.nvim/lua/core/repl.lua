-- Table containing the REPL class: A mixture of Float + Channel
local Repl = {}
Repl.__index = Repl

setmetatable(Repl, {
    __call = function(cls, repl)
        local self  = setmetatable({}, cls)
        self.__repl = repl
        return self
    end
})

-- Open a repl terminal in a floating window
function Repl.open(self, position)

    -- If the terminal is already opened, then ignore
    if self.is_opened then
        vim.notify('REPL terminal is already running. Ignoring.', vim.log.levels.WARN)
        return
    end

    -- Get the current window to jump back at some point
    local original_win = vim.api.nvim_get_current_win()

    -- Generate a floating window where the terminal will be hosted
    self.float = require("core.float")()
    self.float:open(position.X, position.Y, position.W, position.H)

    -- Move to the terminal window and spawn the repl
    vim.api.nvim_set_current_win(self.float.window)

    -- Channel where the terminal is hosted.
    self.channel = vim.fn.termopen(self.__repl)

    -- Set the name of the buffer
    vim.api.nvim_buf_set_name(self.float.buffer, string.format('REPL:%s_%d', self.__repl, math.random(1, 10)))

    -- Set a buffer only autocomommand to enter in insertmode
    self.autocmd_in = vim.api.nvim_create_autocmd(
        "BufEnter", {command="startinsert", buffer=self.float.buffer}
    )

    -- Return to the original window
    vim.api.nvim_set_current_win(original_win)
    self.is_opened = true

    return self
end

-- Close the already opened repl terminal
function Repl.close(self)
    -- Close the terminal floating window
    self.float:close()

    -- Delete the buffer autocommand if possible: protected call
    pcall(vim.api.nvim_del_autocmd, self.autocmd_in)

    -- Close the channel
    vim.fn['chanclose'](self.channel)

    -- The object is closed
    self.is_opened = false
end

-- Toggle the repl terminal
function Repl.toggle_terminal(self)
    self.float:toggle()
    vim.cmd 'stopinsert'
end

-- Control the repl floating window position {{{
function Repl.move_vertical(self, increment)
    self.float:move_vertical(increment)
end
function Repl.move_horizontal(self, increment)
    self.float:move_horizontal(increment)
end
function Repl.resize_width(self, increment)
    self.float:resize_width(increment)
end
function Repl.resize_height(self, increment)
    self.float:resize_height(increment)
end
-- }}}

-- Send a message to the REPL terminal
function Repl.send_message(self, message)
    if not self.is_opened then
        vim.notify('REPL server is not running. Ignoring', vim.log.levels.WARN)
        return
    end
    vim.fn['chansend'](self.channel, string.format('%s \n', message))

    -- Make the terminal go to last position to keep it visually pleasing
    if self.float.is_visible then
        local row = vim.api.nvim_buf_line_count(self.float.buffer)
        vim.api.nvim_win_set_cursor(self.float.window, {row, 1})
    end
end

return Repl
