return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = true,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    lazy = true,
    cmd = { 'Telescope' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local builtin = require('telescope.builtin')

      local buffers
      buffers = function()
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
        defaults = {
          file_ignore_patterns = { 'node_modules', '.git', 'vendor' },
          mappings = {
            i = {
              ['<esc>'] = actions.close,
            },
            n = {
              ['<esc>'] = actions.close,
            },
          },
        },
        picker = {
          find_files = {
            hidden = true,
          },
        },

        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
      })

      telescope.load_extension('ui-select')
      local map = vim.keymap.set

      map('n', '<leader>T', ':Telescope ', { desc = 'Telescope cmd' })
      map('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end, { desc = 'Telescope Find Files' })
      map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
      map('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope Live Grep' })
      map('n', '<leader>fb', buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fQ', builtin.quickfix, { desc = 'Telescope quickfix' })
      map('n', '<leader>fH', builtin.help_tags, { desc = 'Telescope Help Tags' })
      map('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope Old Files' })
      map('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })
      map('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope Jump List' })
      map('n', '<leader>fm', builtin.marks, { desc = 'Telescope Marks' })
      map('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })
      map('n', '<leader>fM', builtin.man_pages, { desc = 'Telescope man pages' })
      map('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })
      map('n', '<leader>fd', function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = 'Telescope Diagnostics (buffer)' })
      map('n', '<leader>fD', builtin.diagnostics, { desc = 'Telescope Diagnostics (CWD)' })
      map('n', '<leader>fS', builtin.lsp_document_symbols, { desc = 'Telescope LSP Document Symbols' })
      map('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP Workspace Symbols' })
      map('n', '<leader>gF', builtin.git_files, { desc = 'Telescope Git Files' })
      map('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git Status' })
      map('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope Git Branches' })

    end,
  },
}
