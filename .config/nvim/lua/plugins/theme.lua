-- Lua
-- Poimandres theme
-- "olivercederborg/poimandres.nvim",
--
return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			-- leave this setup function empty for default config
			-- or refer to the configuration section
			-- for configuration options
		})
		-- Apply to any colorscheme change
		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = function()
				-- Get the current background color
				local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
				if bg then
					-- Lighten the background color slightly for the separator
					local function lighten(color, amount)
						local r = bit.rshift(bit.band(color, 0xFF0000), 16)
						local g = bit.rshift(bit.band(color, 0x00FF00), 8)
						local b = bit.band(color, 0x0000FF)
						r = math.min(255, r + amount)
						g = math.min(255, g + amount)
						b = math.min(255, b + amount)
						return string.format("#%02x%02x%02x", r, g, b)
					end
					vim.api.nvim_set_hl(0, "WinSeparator", {
						fg = lighten(bg, 20), -- adjust amount (20-40 works well)
						bg = "NONE",
					})
				else
					-- Fallback if background can't be determined
					vim.api.nvim_set_hl(0, "WinSeparator", {
						fg = "#3a3a3a",
						bg = "NONE",
					})
				end
			end,
		})
	end,
	init = function()
		vim.cmd("colorscheme catppuccin")
	end,
}
