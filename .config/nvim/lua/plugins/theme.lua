return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			-- vim.cmd("colorscheme kanagawa-wave")
			vim.cmd("colorscheme kanagawa-dragon")
			vim.cmd("colorscheme kanagawa-dragon")
			vim.cmd([[
            highlight LineNr guibg=NONE
            highlight CursorLineNr guibg=NONE
            highlight CursorLine guibg=NONE
            highlight GitSignsAddNr guibg=NONE
            highlight GitSignsChangeNr guibg=NONE
            highlight GitSignsDeleteNr guibg=NONE
            highlight GitSignsChangedeleteNr guibg=NONE
            highlight GitSignsTopdeleteNr guibg=NONE
            ]])
			-- vim.cmd("colorscheme kanagawa-lotus")
		end,
	},
}
