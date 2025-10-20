-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
	config = function()
		vim.keymap.set(
			"n",
			"<leader>tb",
			"<cmd>Gitsigns toggle_current_line_blame<cr>",
			{ noremap = true, silent = true }
		)
	end,
}
