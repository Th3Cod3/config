return {
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    cmd = { 'Telescope' },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local config = require('th3cod3.config.telescope')

      telescope.setup({})

      local map = vim.keymap.set
      map('n', '<leader>ft', config.terminal_picker, { desc = 'Telescope Terminals' })
      map('n', 'z=', builtin.spell_suggest, { desc = 'Telescope spell suggest' })
    end,
  },
}
