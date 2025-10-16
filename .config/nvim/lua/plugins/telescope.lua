return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
          local builtin = require('telescope.builtin')
          vim.keymap.set('n','<leader>ff',builtin.find_files,{desc="Find Files in your project"})
          vim.keymap.set('n','<leader>fg',builtin.live_grep,{desc="Find a certian text in your project"})
      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', {noremap=true, silent=true, desc="Find All Todos"})
      end

    }

