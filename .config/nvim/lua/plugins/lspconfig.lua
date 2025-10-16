return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			opts = {
				ensure_installed = { "lua_ls", "bashls", "biome" },
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			{
				"neovim/nvim-lspconfig",

				-- config = function()
				--     vim.keymap.set('n', '<leader>f', function()
				--         vim.lsp.buf.format({ async = true })
				--     end
				--     , { desc = "Find Files in your project" })
				-- end
			},
		},
	},
}
