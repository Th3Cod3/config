return {
  {
    'danymat/neogen',
    ft = { 'c', 'cpp' },
    config = function()
      local neogen = require('neogen')
      neogen.setup({})

      local map = vim.keymap.set
      map('n', '<leader>nf', neogen.generate, { desc = 'Generate Doxygen' })
      map( 'n', '<leader>nc', function () neogen.generate({ type = 'class'}) end, { desc = 'Generate class Doxygen' })
    end,
  },
}
