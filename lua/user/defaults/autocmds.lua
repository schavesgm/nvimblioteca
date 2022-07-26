local create_autocmd = require("user.core.autocmds").create_autocmd

-- Local variable containing all the timed_autocommands
local timers = {}

-- Wrapper around a callback function to generate a timed loop
local function start_timed_callback(callback, start, every)
    return function()
        local bufnr  = vim.api.nvim_buf_get_name(0)
        local lambda = vim.schedule_wrap(function() callback(bufnr) end)
        timers[bufnr] = vim.loop.new_timer()
        timers[bufnr]:start(start, every, lambda)
    end
end

-- Function that closes an already opened timed function
local function end_timed_callback()
    -- Get the current buffer name
    local bufnr = vim.api.nvim_buf_get_name(0)

    -- If the timer does exist, then close it
    if (timers[bufnr] ~= nil) then
        timers[bufnr]:close()
        timers[bufnr] = nil
    end
end

-- Small function used to save a buffer by its buffer name
local function save_buffer(bufnr)
    vim.cmd(':w ' .. bufnr)
end

-- Small function to convert minutes to miliseconds
local function to_milisecodns(minutes)
    return minutes * 60 * 1000
end

-- Table containing all autogroups/autocommands definitions
return {
    RestoreCursor = {
        create_autocmd("BufRead", {pattern="*", command=[[call setpos(".", getpos("'\""))]]})
    },
    TerminalJob = {
        create_autocmd("TermOpen", {pattern="*", command=[[tnoremap <buffer> <Esc> <c-\><c-n>]]}),
        create_autocmd("TermOpen", {pattern="*", command="startinsert"}),
        create_autocmd("TermOpen", {pattern="*", command=[[setlocal nonumber norelativenumber]]}),
        create_autocmd("TermOpen", {pattern="*", command=[[setlocal filetype=term]]}),
    },
    SaveToShada = {
        create_autocmd("VimLeave", {pattern="*", command="wshada!"}),
    },
    MarkupAutocmds = {
        create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal textwidth=100 colorcolumn=100]]}),
        create_autocmd("FileType", {pattern={"tex", "text", "markdown"}, command=[[setlocal spell]]}),
        create_autocmd("BufEnter", {pattern={"*.tex", "*.md"}, callback=start_timed_callback(save_buffer, to_milisecodns(3), to_milisecodns(3))}),
        create_autocmd("BufLeave", {pattern={"*.tex", "*.md"}, callback=end_timed_callback})
    },
}
