-- Load some needed helper functions
local generate_spaces = require'formatequal.helpers'.generate_spaces
local str_insert      = require'formatequal.helpers'.str_insert

-- Look for the longest column in a set of lines where a reference char is present
local function get_longest_column(lines, reference_char)

    -- Buffer containing the longest column containing sign
    local longest_col = -1

    -- Iterate for all lines
    for _, line in ipairs(lines) do

        -- Ignore empty lines or comment lines
        if line == "" or line:find('^#') ~= nil then goto continue end

        -- Get the position of the sign
        local char_pos = line:find(reference_char)

        -- If one line does not contain the sign character, then return -1
        if not (char_pos ~= nil) then
            return -1
        else
            longest_col = math.max(longest_col, char_pos)
        end

        ::continue::
    end
    return longest_col
end

-- Format some lines according to a given reference character
local function make_equal_format(lines, line_nr, reference_char)

    -- Get the longest column containing the = sign
    local longest = get_longest_column(lines, reference_char)

    -- First, check that all lines contain the same sign character
    if longest < 0 then return false end

    -- Iterate through all lines in the collection
    for nr, line in ipairs(lines) do

        -- Ignore empty lines or comment lines
        if line == "" or line:find('^#') ~= nil then goto continue end

        -- Get the position of the special character in the line
        local char_pos = line:find(reference_char)

        -- Transform the line by adding some spaces to it
        line = str_insert(line, generate_spaces(longest - char_pos), char_pos - 1)

        -- Substitute the line in the current position
        vim.fn['setline'](line_nr + nr, line)

        ::continue::
    end
    return true
end

return {
    get_longest_column = get_longest_column,
    make_equal_format  = make_equal_format,
}
