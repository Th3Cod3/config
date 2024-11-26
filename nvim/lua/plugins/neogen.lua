return {
  {
    'danymat/neogen',
    ft = { 'c', 'cpp' },
    config = function()
      require('neogen').setup({})

      vim.api.nvim_set_keymap('n', '<leader>nf', ":lua require('neogen').generate()<cr>", { desc = 'Generate Doxygen' })
      vim.api.nvim_set_keymap(
        'n',
        '<leader>nc',
        ":lua require('neogen').generate({ type = 'class'})<cr>",
        { desc = 'Generate class Doxygen' }
      )
    end,
  },
}
