return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			opts = {
				ensure_installed = { "lua_ls", "bashls" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"neovim/nvim-lspconfig",

				config = function(event)
					-- Neovim 0.11+ style
					vim.lsp.config.gdscript = {
						cmd = { "nc", "localhost", "6005" },
						name = "godot",
					}

					-- Start automatically for .gd files
					vim.api.nvim_create_autocmd("FileType", {
						pattern = "gdscript",
						callback = function()
							vim.lsp.start(vim.lsp.config.gdscript)
						end,
					})
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				end,
			},
		},
	},
}
