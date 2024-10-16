return {
  {
    'alexghergh/nvim-tmux-navigation',
    config = function()
      require('nvim-tmux-navigation').setup({})
      vim.keymap.set('n', '<M-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', { desc = 'Navigate Left' })
      vim.keymap.set('n', '<M-j>', '<Cmd>NvimTmuxNavigateDown<CR>', { desc = 'Navigate Down' })
      vim.keymap.set('n', '<M-k>', '<Cmd>NvimTmuxNavigateUp<CR>', { desc = 'Navigate Up' })
      vim.keymap.set('n', '<M-l>', '<Cmd>NvimTmuxNavigateRight<CR>', { desc = 'Navigate Right' })
    end,
  },
}
