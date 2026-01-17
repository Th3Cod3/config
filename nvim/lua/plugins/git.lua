return {
  {
    'ruifm/gitlinker.nvim',
    keys = {
      {
        '<leader>gyr',
        function()
          local url = require('gitlinker').get_repo_url({
            print_url = false,
          })
        end,
        desc = 'Git: Copy remote repo URL',
      },
      {
        '<leader>gor',
        function()
          require('gitlinker').get_repo_url({
            print_url = false,
            action_callback = require('th3cod3.functions').open_url,
          })
        end,
        desc = 'Git: Open repo (in browser)',
      },
      {
        '<leader>gyl',
        function() require('gitlinker').get_buf_range_url('n') end,
        desc = 'Git: Copy file line remote permalink',
      },
      {
        '<leader>gy',
        function() require('gitlinker').get_buf_range_url('v') end,
        mode = 'v',
        desc = 'Git: Copy file line remote permalink',
      },
      {
        '<leader>gol',
        function()
          require('gitlinker').get_buf_range_url('n', {
            action_callback = require('th3cod3.functions').open_url,
          })
        end,
        desc = 'Git: Open remote permalink (in browser)',
      },
      {
        '<leader>go',
        function()
          require('gitlinker').get_buf_range_url('v', {
            action_callback = require('th3cod3.functions').open_url,
          })
        end,
        mode = 'v',
        desc = 'Git: Open remote permalink (in browser)',
      },
      {
        '<leader>gom',
        function()
          require('gitlinker').get_repo_url({
            print_url = false,
            action_callback = function(url)
              vim.system({ 'git' }, { args = { 'branch', '--show-current' } }, function(obj)
                local branch = obj.stdout:gsub('%s+', '')
                url = url .. '/compare/master...' .. branch
                vim.notify('Opening URL: ' .. url, vim.log.levels.DEBUG, { title = 'Git' })
                require('th3cod3.functions').open_url(url)
              end)
            end,
          })
        end,
        desc = 'Git: Open compare branch with master',
      },
      {
        '<leader>god',
        function()
          require('gitlinker').get_repo_url({
            action_callback = function(url)
              vim.system({ 'git' }, { args = { 'branch', '--show-current' } }, function(obj)
                local branch = obj.stdout:gsub('%s+', '')
                url = url .. '/compare/master...' .. branch
                vim.notify('Opening URL: ' .. url, vim.log.levels.DEBUG, { title = 'Git' })
                require('th3cod3.functions').open_url(url)
              end)
            end,
          })
        end,
        desc = 'Git: Open compare branch with dev',
      },
    },
    config = function() require('gitlinker').setup() end,
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
    opts = {
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup({
        current_line_blame = true,
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        on_attach = function(bufnr)
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
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[Un]Stage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
          map(
            'v',
            '<leader>hs',
            function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
            { desc = '[Un]Stage hunk' }
          )
          map(
            'v',
            '<leader>hr',
            function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
            { desc = 'Reset hunk' }
          )
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[Un]Stage buffer' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = 'Toggle blame line' })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })

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
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
