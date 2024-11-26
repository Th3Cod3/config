return {
  { 'nvim-telescope/telescope-ui-select.nvim' },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local builtin = require('telescope.builtin')

      local buffers = function ()
        builtin.buffers({
          sort_lastused = true,
          ignore_current_buffer = true,
          attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            end

            map('n', 'd', delete_buf)

            return true
          end,
        })
      end

      telescope.setup({
        picker = {
          find_files = {
            hidden = true,
          },
        },

        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
      })

      local map = vim.keymap.set

      map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
      map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
      map('n', '<leader>fb', buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fq', buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
      map('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope Old Files' })
      map('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })
      map('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })
      map('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
      map('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })
      map('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope Diagnostics' })
      map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP Document Symbols' })

      telescope.load_extension('ui-select')
    end,
  },
}
