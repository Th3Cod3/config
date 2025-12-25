local map = vim.keymap.set
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local opts = { buffer = true, silent = true }

    map('n', 'gf', '<C-w>gf', opts)
    map('n', 'gF', '<C-w>gF', opts)
  end,
})

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local term = require('toggleterm')
      term.setup({
        direction = 'float',
        shell = 'bash',
        shell_args = { '-l' },
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
