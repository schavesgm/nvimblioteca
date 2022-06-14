-- Filter the table according to one condition
-- @table [arr]: Array-like table
-- @condition [func]: Function implementing the condition: Returns boolean
local function filter(table, condition)
    local new_table = {}
    local new_index = 1
    for _, value in ipairs(table) do
        if condition(value) then
            new_table[new_index] = value
            new_index = new_index + 1
        end
    end
    return new_table
end

-- Check if a string starts with a given substring
local function string_starts(string, start)
   return string.sub(string, 1, string.len(start)) == start
end

-- Get the number of elements in a table
local function table_length(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

-- Filter the lines using a condition on each line
local function filter_lines(lines, condition)
    if #lines == 0 then return '\n' end
    lines = condition ~= nil and filter(lines, condition) or lines
    return string.format("%s", table.concat(lines, '\n'))
end

-- Get the visual selection, applying some conditions to strip unwanted lines
local function get_visual_selection(condition)
    local start  = vim.fn['getpos']("'<")
    local finish = vim.fn['getpos']("'>")
    local lines  = vim.fn['getline'](start[2], finish[2])
    return filter_lines(lines, condition)
end

-- Get the whole selection, applying some conditions to strip unwanted lines
local function get_whole_file(condition)
    local lines  = vim.fn['getline'](0, '$')
    return filter_lines(lines, condition)
end

return {
    filter               = filter,
    string_starts        = string_starts,
    table_length         = table_length,
    get_visual_selection = get_visual_selection,
    get_whole_file       = get_whole_file,
}
