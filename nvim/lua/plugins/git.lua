return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    config = function()
      vim.keymap.set('n', '<leader>gS', ':Git<CR>', { desc = 'Git fugitive', noremap = true })
      vim.keymap.set('n', '<leader>gB', ':Git blame<CR>', { desc = 'Git fugitive blame', noremap = true })
    end,
  },

  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
      'DiffviewRefresh',
      'DiffviewToggleFile',
      'DiffviewFileHistory',
      'DiffviewToggleOption',
    },
    keys = {
      { '<leader>gd', ':DiffviewOpen<cr>', desc = 'Diffview open' },
      { '<leader>gx', ':DiffviewClose<cr>', desc = 'Diffview close' },
      { '<leader>gh', ':DiffviewFileHistory<cr>', desc = 'Diffview history (commits)' },
      { '<leader>gb', ':DiffviewFileHistory %<cr>', desc = 'Current buffer git history' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']h', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']h', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = 'Next hunk' })

          map('n', '[h', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[h', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = 'Previous hunk' })

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = 'Stage hunk' })
          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end, { desc = 'Reset hunk' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, { desc = 'Blame line' })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Diff this (cached)' })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end,
      })
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
