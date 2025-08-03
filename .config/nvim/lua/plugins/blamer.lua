-- This will help you toggle blamer on and off
return {
"APZelos/blamer.nvim",
  config = function()
vim.keymap.set("n", "<leader>tb", "<cmd>BlamerToggle<cr>", { noremap = true, silent = true })
  end
}
