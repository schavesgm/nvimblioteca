return {
	settings = {
		Lua = {
			diagnostics = {
			    globals = {"vim", "awesome", "client", "mouse", "screen", "tag", "root"},
			},
			workspace = {
				library = {
				    [vim.fn.expand("$VIMRUNTIME/lua")]    = true,
					[vim.fn.stdpath("config") .. "/lua"]  = true,
				},
			},
		},
	},
}
