return {
  { 'nvim-telescope/telescope-ui-select.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        picker = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
      })
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope Old Files' })
      vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })
      vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope Diagnostics' })
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP Document Symbols' })

      require('telescope').load_extension('ui-select')
    end,
  },
}
