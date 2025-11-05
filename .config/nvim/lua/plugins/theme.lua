-- Using Lazy
return {
	{
		"kyza0d/xeno.nvim",
		lazy = false,
		priority = 1000, -- Load colorscheme early
		config = function()
			-- Create your custom theme here
			require("xeno").new_theme("my-theme", {
				base = "#1E1E1E",
				accent = "#CD974B",
			})
			vim.cmd("colorscheme my-theme")
		end,
	},
	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				-- optional configuration here
			})
			-- vim.cmd("colorscheme vague")
		end,
	},
}
