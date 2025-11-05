return {
	-- {
	-- 	"nvim-mini/mini.icons",
	-- 	version = false,
	-- 	config = function()
	-- 		require("mini.icons").setup({})
	-- 	end,
	-- },

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			--bracket pair setting {}, () etc
			require("mini.pairs").setup()

			-- require("mini.git").setup()
			require("mini.diff").setup()
		end,
	},
}
