local function is_empty(s)
    -- Check if a line is empty or only contain spaces
    return (s == nil) or (s == '') or (not not string.match(s, "^%s*$"))
end

local function contains_any(s, strings)
    -- Check if a string starts with any of the strings in the list
    for _, v in ipairs(strings) do
        if not not string.match(s, "^" .. v) then
            return true
        end
    end
    return false
end

local function look(cline, is_above, delimiters)
    -- Find the beginning or end of a paragraph using some delimiters
    while true do
        cline = (is_above) and (cline - 1) or (cline + 1)
        local line = vim.fn['getline'](cline)

        -- Check if line is empty or line starts with delimiter
        if (is_empty(line) or contains_any(line, delimiters)) then
            return (is_above) and (cline + 1) or (cline - 1)
        end
    end
end

return {
    is_empty     = is_empty,
    contains_any = contains_any,
    look         = look,
}
