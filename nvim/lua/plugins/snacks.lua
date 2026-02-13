local seeEverythingOpts = {
  hidden = true,
  ignored = true,
  follow = true,
}

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = {},
      gh = {},
      -- gitbrowse = {},
      indent = {},
      input = {},
      lazygit = {},
      notifier = {},
      notify = {},
      picker = {
        auto_refresh = false,
        live = false,
        win = {
          input = {
            keys = {
              ['<a-e>'] = { 'focus_preview', mode = { 'i', 'n' } },
              ['<C-j>'] = { 'history_forward', mode = { 'i', 'n' } },
              ['<C-k>'] = { 'history_back', mode = { 'i', 'n' } },
              ['<a-p>'] = false, -- 'toggle_preview',
              ['<c-p>'] = { 'toggle_preview', mode = { 'i', 'n' } },
              ['<a-x>'] = { 'toggle_regex', mode = { 'i', 'n' } },
              ['<a-r>'] = false, -- 'toggle_regex'
              ['<a-z>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
              ['<a-m>'] = false, -- 'toggle_maximize'
            },
          },
          -- result list window
          list = {
            keys = {
              ['<a-e>'] = 'focus_preview',
              ['<a-z>'] = { 'toggle_maximize', mode = { 'i', 'n' } },
              ['<a-m>'] = false, -- 'toggle_maximize',
              ['<c-p>'] = 'toggle_preview',
              ['<a-p>'] = false, -- 'toggle_preview',
              ['<c-d>'] = false, -- 'list_scroll_down',
              ['<c-j>'] = false, -- 'list_down',
              ['<c-k>'] = false, -- 'list_up',
              ['<c-n>'] = false, -- 'list_down',
              ['<c-u>'] = false, -- 'list_scroll_up',
            },
          },
          preview = {
            keys = {
              ['<a-e>'] = 'focus_input',
            },
          },
        },
      },
      quickfix = {},
      rename = {},
      scratch = {},
      scope = {},
      -- statuscolumn = {},
      styles = {},
      win = {},
      words = {},
    },
    keys = {
      -- GIT
      { '<leader>gi', function() Snacks.picker.gh_issue() end, desc = 'GitHub Issues (open)' },
      { '<leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, desc = 'GitHub Issues (all)' },
      { '<leader>gp', function() Snacks.picker.gh_pr() end, desc = 'GitHub Pull Requests (open)' },
      { '<leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end, desc = 'GitHub Pull Requests (all)' },
      { '<leader>gg', function() Snacks.lazygit.open() end, desc = 'Lazygit' },
      { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log' },
      { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line' },
      { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
      { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
      { '<leader>gD', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)' },
      { '<leader>gF', function() Snacks.picker.git_files() end, desc = 'Find Git Files' },
      -- { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File' },
      -- { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },

      -- Top Pickers & Explorer
      { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>fn', function() Snacks.picker.notifications() end, desc = 'Notification History' },
      { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
      { '<leader>fF', function() Snacks.picker.files(seeEverythingOpts) end, desc = 'Find Files (all)' },
      { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
      { '<leader>fo', function() Snacks.picker.recent() end, desc = 'Recent' },
      -- { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },

      -- Grep
      { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
      { '<leader>fB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
      { '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep' },
      { '<leader>fG', function() Snacks.picker.grep(seeEverythingOpts) end, desc = 'Grep (all)' },
      {
        '<leader>fs',
        function() Snacks.picker.grep_word() end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      {
        '<leader>fS',
        function() Snacks.picker.grep_word(seeEverythingOpts) end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },

      -- search
      { '<leader>fr', function() Snacks.picker.registers() end, desc = 'Registers' },
      { '<leader>f/', function() Snacks.picker.search_history() end, desc = 'Search History' },
      { '<leader>fa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
      { '<leader>fC', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>fc', function() Snacks.picker.commands() end, desc = 'Commands' },
      { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
      { '<leader>fD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
      { '<leader>fh', function() Snacks.picker.help() end, desc = 'Help Pages' },
      { '<leader>fH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
      { '<leader>fi', function() Snacks.picker.icons() end, desc = 'Icons' },
      { '<leader>fj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
      { '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
      { '<leader>fl', function() Snacks.picker.loclist() end, desc = 'Location List' },
      { '<leader>fM', function() Snacks.picker.marks() end, desc = 'Marks' },
      { '<leader>fm', function() Snacks.picker.man() end, desc = 'Man Pages' },
      { '<leader>fp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
      { '<leader>fq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
      { '<leader><leader><leader>', function() Snacks.picker.resume() end, desc = 'Resume' },
      { '<leader>fu', function() Snacks.picker.undo() end, desc = 'Undo History' },
      { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },

      -- LSP
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
      { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
      { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
      { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
      { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition' },
      { 'gai', function() Snacks.picker.lsp_incoming_calls() end, desc = 'C[a]lls Incoming' },
      { 'gao', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'C[a]lls Outgoing' },
      { '<leader>fls', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
      { '<leader>flS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },

      -- others
      { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
      { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom' },
      { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
      { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
      { '<leader>un', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications' },
      { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal' },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          require('snacks')
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end

          -- Override print to use snacks for `:=` command
          if vim.fn.has('nvim-0.11') == 1 then
            vim._print = function(_, ...) dd(...) end
          else
            vim.print = _G.dd
          end

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
          Snacks.toggle.diagnostics():map('<leader>ud')
          Snacks.toggle.line_number():map('<leader>ul')
          Snacks.toggle
            .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map('<leader>uc')
          Snacks.toggle.treesitter():map('<leader>uT')
          Snacks.toggle.inlay_hints():map('<leader>uh')
          Snacks.toggle.indent():map('<leader>ug')

          vim.api.nvim_create_autocmd('FileType', {
            pattern = 'snacks_picker*',
            callback = function()
              vim.bo.buftype = 'nofile'
              vim.bo.bufhidden = 'wipe'
              vim.bo.swapfile = false
            end,
          })
        end,
      })
    end,
    config = function(_, opts) Snacks.setup(opts) end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    keys = {
      { '<leader>st', function() Snacks.picker.todo_comments() end, desc = 'Todo' },
      {
        '<leader>sT',
        function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end,
        desc = 'Todo/Fix/Fixme',
      },
    },
  },
}
