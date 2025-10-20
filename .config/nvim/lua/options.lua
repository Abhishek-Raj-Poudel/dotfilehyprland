-- Enable line number
vim.opt.number = true

-- Enable relative line number
vim.opt.relativenumber = true

-- Hightlight current line's number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Enable split below eg when writing the command :help now it show help below
vim.opt.splitbelow = true

-- Use space as tab, you can still use tabs but not on save they will be space
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- idk why it's called unnambedplus
vim.opt.clipboard = "unnamedplus"

-- This will keep your cursor in the middle whle scrolling
vim.opt.scrolloff = 999

-- in visual block(ctrl + v) mode you cannot select beyond the end of your cursor's end but now you can
vim.opt.virtualedit = "block"

-- this shows which lines will be effected by a given changes in a split
vim.opt.inccommand = "split"

-- some commands are in upper and some in lower case, it will ignore that so that everying is in lowercase / uppercase
vim.opt.ignorecase = true

-- enable all colors
vim.opt.termguicolors = true

vim.opt.conceallevel = 2

-- Leader key is now set to space
vim.g.mapleader = " "

vim.keymap.set("n", "<C-\\>", "<cmd>vs<cr>", { noremap = true, silent = true, desc = "Split vertically" })
vim.keymap.set("n", "<leader>\\", "<cmd>vs<cr>", { noremap = true, silent = true, desc = "Split vertically" })

-- Setup diagnostic

vim.diagnostic.config({
	virtual_lines = true, -- show inline messages (right side)
	signs = true, -- show signs in the gutter
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- For filetree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- the verticle split line looks atrocious, so made it a bit bareable
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinding ctrl + hjkl switches between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- IDK what this does
vim.o.list = true
vim.opt.listchars = { tab = "| ", trail = "·", nbsp = "␣" }
