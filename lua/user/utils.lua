local M = {}

-- Deepcopy a table
-- @returns table
function M.deepcopy_table(table)
	local copy = {}
	for k, v in pairs(table) do
		if type(v) == "table" then
			v = M.deepcopy_table(v)
		end
		copy[k] = v
	end
	return copy
end

-- Pop the key of a table and return its value
-- @returns any
function M.pop_key(key, table)
    local value = table[key]
    table[key] = nil
    return value
end

-- Get all keys from a table as a table
-- @returns table
function M.get_keys(table)
    local keys  = {}
    local count = 1
    for key, _ in pairs(table) do
        keys[count] = key
        count = count + 1
    end
    return keys
end

return M
