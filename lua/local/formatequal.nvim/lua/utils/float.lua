-- Some helper functions to deal with floating window positioning
local function get_col_coords(X, ui_width, win_width)
    if     X == "L" then
        return 7
    elseif X == "C" then
        return math.ceil((ui_width - win_width) / 2) - 1
    elseif X == "R" then
        return (ui_width - win_width) - 3
    else
        vim.notify('X available coordinates are: L, C and R. Passed: ' .. X, vim.log.levels.ERROR)
        return
    end
end

local function get_row_coords(Y, ui_height, win_height)
    if     Y == "T" then
        return 1
    elseif Y == "M" then
        return math.ceil((ui_height - win_height) / 2 - 1)
    elseif Y == "B" then
        return (ui_height - win_height) - 3
    else
        vim.notify('Y available coordinates are: T, M and B. Passed: ' .. Y, vim.log.levels.ERROR)
        return
    end
end

local function get_float_config(X, Y, wp, hp)
    -- Get some properties of the window
    local stats     = vim.api.nvim_list_uis()[1]
    local ui_width   = stats.width
    local ui_height  = stats.height
    local win_width  = math.ceil(stats.width * wp)
    local win_height = math.ceil(stats.height * hp)

    -- Define the coordinates
    local col = get_col_coords(X, ui_width,  win_width)
    local row = get_row_coords(Y, ui_height, win_height)

    return {
        width  = win_width,
        height = win_height,
        row    = row,
        col    = col
    }
end

return {
    get_col_coords          = get_col_coords,
    get_row_coords          = get_row_coords,
    get_float_config_coords = get_float_config
}
