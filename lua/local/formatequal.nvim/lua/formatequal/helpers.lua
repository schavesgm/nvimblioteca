-- Function used to insert a string inside another string at a given position
local function str_insert(str1, str2, pos)
    return str1:sub(1,pos) .. str2 .. str1:sub(pos+1)
end

-- Function used to generate a string containing a sequence of spaces
local function generate_spaces(seq_len)
    local string = ""
    for _ = 1, seq_len do
        string = string .. " "
    end
    return string
end

return {
    str_insert      = str_insert,
    generate_spaces = generate_spaces,
}
