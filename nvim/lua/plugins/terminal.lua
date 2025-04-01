function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }

  vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('n', 'gf', '<C-w>gf', opts)
  vim.keymap.set('n', 'gF', '<C-w>gF', opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local term = require('toggleterm')
      term.setup({
        direction = 'float',
      })

      local map = vim.keymap.set

      map('n', '<C-t>', term.toggle, { desc = 'Toggle terminal' })
      map('n', '<leader>tv', ':ToggleTerm direction=vertical<cr>', { desc = 'Toggle terminal (vertical)' })
      map('n', '<leader>th', ':ToggleTerm direction=horizontal<cr>', { desc = 'Toggle terminal (horizontal)' })
      map('t', '<C-t>', term.toggle, { desc = 'Toggle terminal' })
      map('n', '<leader>tl', ':TermSelect<cr>', { desc = 'Select terminal' })
    end,
  },
}
