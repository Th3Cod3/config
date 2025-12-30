local map = vim.keymap.set

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    local opts = { buffer = true, silent = true }

    map('n', 'gf', '<C-w>gf', opts)
    map('n', 'gF', '<C-w>gF', opts)
    map('t', '<M-H>', [[<Cmd>wincmd h<CR>]], opts)
    map('t', '<M-J>', [[<Cmd>wincmd j<CR>]], opts)
    map('t', '<M-K>', [[<Cmd>wincmd k<CR>]], opts)
    map('t', '<M-L>', [[<Cmd>wincmd l<CR>]], opts)
  end,
})

return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      local term = require('toggleterm')
      local Teminal = require('toggleterm.terminal').Terminal

      local globalTerminal = Teminal:new({
        cmd = 'bash -l',
        hidden = true,
        display_name = 'Global Terminal',
        close_on_exit = true,
        auto_scroll = true,
        direction = 'float',
      })

      term.setup({
        direction = 'float',
      })

      map('n', '<C-t>', function() globalTerminal:toggle() end, { desc = 'Toggle terminal' })
      map('n', '<leader>tv', ':ToggleTerm direction=vertical<cr>', { desc = 'Toggle terminal (vertical)' })
      map('n', '<leader>th', ':ToggleTerm direction=horizontal<cr>', { desc = 'Toggle terminal (horizontal)' })
      map('n', '<leader>tf', ':ToggleTerm direction=float<cr>', { desc = 'Toggle terminal (float)' })
      map('t', '<C-t>', function() globalTerminal:toggle() end, { desc = 'Toggle terminal' })
      map('n', '<leader>tl', ':TermSelect<cr>', { desc = 'Select terminal' })
    end,
  },
}
