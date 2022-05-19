return {
	settings = {
		Lua = {
			diagnostics = {
			    globals = {"vim"}, -- Add vim as a global
			},
			workspace = {
				library = {
				    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
