return {{
    'Shatur/neovim-ayu',
},{ "catppuccin/nvim", name = "catppuccin", priority = 1000,

    config = function()
        vim.cmd.colorscheme("catppuccin")
    end
}}
