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

      local buffers
      buffers = function ()
        builtin.buffers({
          sort_mru = true,
          ignore_current_buffer = true,
          attach_mappings = function(prompt_bufnr, map)
            local delete_buf = function()
              local selection = action_state.get_selected_entry()
              -- @todo: refresh buffer list after deletion
              -- local picker = action_state.get_current_picker(prompt_bufnr)
              -- picker:refresh()
              actions.close(prompt_bufnr)
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              buffers()
            end

            map('n', 'd', delete_buf)
            map('i', '<c-d>', delete_buf)

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

      map('n', '<leader>T', ':Telescope ', { desc = 'Telescope cmd' })
      map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
      map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
      map('n', '<leader>fb', buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fq', buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
      map('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope Old Files' })
      map('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })
      map('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope Jump List' })
      map('n', '<leader>fm', builtin.marks, { desc = 'Telescope Marks' })
      map('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })
      map('n', '<leader>fM', builtin.man_pages, { desc = 'Telescope man pages' })
      map('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })
      map('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope Diagnostics' })
      map('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP Document Symbols' })
      map('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP Workspace Symbols' })
      map('n', '<leader>gf', builtin.git_files, { desc = 'Telescope Git Files' })
      map('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git Status' })
      map('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope Git Commits' })
      map('n', '<leader>gp', builtin.git_bcommits, { desc = 'Telescope Git BCommits' })
      map('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope Git Branches' })

      telescope.load_extension('ui-select')
    end,
  },
}
