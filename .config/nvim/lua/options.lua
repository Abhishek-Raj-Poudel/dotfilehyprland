-- Enable line number
vim.opt.number = true

-- Set terminal to zsh
vim.o.shell = "/bin/zsh"

-- Enable relative line number
vim.opt.relativenumber = true

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

vim.keymap.set('n','<C-\\>','<cmd>vs<cr>',{noremap=true, silent=true,desc="Split vertically"})
vim.keymap.set('n','<leader>\\','<cmd>vs<cr>',{noremap=true, silent=true,desc="Split vertically"})

--cycle through windows
vim.keymap.set("n", "<leader>j", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>th', ':split term://zsh<CR>', { noremap = true })
-- Setup diagnostic 

vim.diagnostic.config({
    virtual_lines = true,     -- show inline messages (right side)
    signs = true,            -- show signs in the gutter
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

