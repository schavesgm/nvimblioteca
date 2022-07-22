vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern="*.org",
    command=":set filetype=org",
    group=vim.api.nvim_create_augroup("Ltex", {clear=false}),
})

-- Manually added words to the dictionary are ignored by the server
local ignore_words = {}
for _, code in ipairs({"en-GB", "es"}) do
    local dict_name = string.format("spell/%s.utf-8.add", code:gsub("-GB", ""))
    local dict_path = _G.join_paths(_G.config_path, dict_name)

    if _G.is_file(dict_path) then
        ignore_words[code] = vim.fn['readfile'](dict_path)
    end
end

return  {
    settings = {
        ltex = {
            language           = "en-GB",
            dictionary         = ignore_words,
            diagnosticSeverity = "information",
            checkFrequency     = "edit",
            completionEnabled  = true,
            disabledRules      = {
                ["en-GB"] = {"OXFORD_SPELLING_Z_NOT_S"},
            },
            additionalRules    = {
                motherTongue = "es",
            },
            logLevel = {"fine"},
        },
    },
}
