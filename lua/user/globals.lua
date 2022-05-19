local sep_path = vim.loop.os_uname().version:match "Windows" and "\\" or "/"

-- Join two path segments into one
-- @param paths to be concatenated
-- @returns string
function _G.join_paths(...)
    return table.concat({...}, sep_path):gsub(sep_path .. sep_path,  sep_path)
end

-- Check if Nvim is in headless mode
-- @returns bool
function _G.in_headless()
    return #vim.api.nvim_list_uis() == 0
end

-- Checks whether a given path exists and is a directory
-- @param string path to check
-- @returns bool
function _G.is_directory(path)
    local stat = vim.loop.fs_stat(path)
    return vim.loop.fs_stat(path) and stat.type == "directory" or false
end

-- Checks whether a given path exists and is a file
-- @param string path to check
-- @returns bool
function _G.is_file(path)
    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file" or false
end
