local filesMappings = require('th3cod3.config.telescope').filesMappings

return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
    lazy = true,
  },

  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.8',
    lazy = true,
    cmd = { 'Telescope' },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local config = require('th3cod3.config.telescope')

      telescope.setup({
        defaults = {
          file_ignore_patterns = { 'node_modules/', '.git/', 'vendor/' },
          preview = {
            hide_on_startup = true,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            mappings = filesMappings,
          },
          live_grep = {
            mappings = filesMappings,
          },
          help_tags = {
            mappings = filesMappings,
          },
          oldfiles = {
            mappings = filesMappings,
          },
          lsp_definitions = {
            mappings = filesMappings,
          },
          lsp_references = {
            mappings = filesMappings,
          },
          lsp_implementations = {
            mappings = filesMappings,
          },
          lsp_type_definitions = {
            mappings = filesMappings,
          },
          buffers = {
            mappings = filesMappings,
            sort_mru = true,
            ignore_current_buffer = true,
          },
          man_pages = {
            mappings = vim.tbl_deep_extend('force', filesMappings, {
              i = {
                ['<F1>'] = function() builtin.man_pages({ sections = { '1' } }) end,
                ['<F2>'] = function() builtin.man_pages({ sections = { '2' } }) end,
                ['<F3>'] = function() builtin.man_pages({ sections = { '3' } }) end,
                ['<F4>'] = function() builtin.man_pages({ sections = { '4' } }) end,
                ['<F5>'] = function() builtin.man_pages({ sections = { '5' } }) end,
                ['<F6>'] = function() builtin.man_pages({ sections = { '6' } }) end,
                ['<F7>'] = function() builtin.man_pages({ sections = { '7' } }) end,
                ['<F8>'] = function() builtin.man_pages({ sections = { '8' } }) end,
                ['<F9>'] = function() builtin.man_pages({ sections = { '9' } }) end,
                ['<F12>'] = function() builtin.man_pages({ sections = { 'ALL' } }) end,
              },
              n = {
                ['<F1>'] = function() builtin.man_pages({ sections = { '1' } }) end,
                ['<F2>'] = function() builtin.man_pages({ sections = { '2' } }) end,
                ['<F3>'] = function() builtin.man_pages({ sections = { '3' } }) end,
                ['<F4>'] = function() builtin.man_pages({ sections = { '4' } }) end,
                ['<F5>'] = function() builtin.man_pages({ sections = { '5' } }) end,
                ['<F6>'] = function() builtin.man_pages({ sections = { '6' } }) end,
                ['<F7>'] = function() builtin.man_pages({ sections = { '7' } }) end,
                ['<F8>'] = function() builtin.man_pages({ sections = { '8' } }) end,
                ['<F9>'] = function() builtin.man_pages({ sections = { '9' } }) end,
                ['<F12>'] = function() builtin.man_pages({ sections = { 'ALL' } }) end,
              },
            }),
            sections = { 'ALL' },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      telescope.load_extension('ui-select')
      local map = vim.keymap.set

      map('n', '<leader>T', ':Telescope ', { desc = 'Telescope cmd' })
      map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files' })
      map('n', '<leader><leader><leader>', builtin.resume, { desc = 'Telescope Resume' })
      map('n', '<leader>ft', config.terminal_picker, { desc = 'Telescope Terminals' })
      map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep' })
      map(
        'n',
        '<leader>sb',
        function() builtin.live_grep({ grep_open_files = true }) end,
        { desc = 'Telescope Live Grep (open files)' }
      )
      map('n', '<leader>sc', function()
        -- @todo: improve to add conditional (git or not git)
        local glob_pattern = vim.fn.systemlist('git diff --name-only')[1]
        builtin.live_grep({ glob_pattern = glob_pattern })
      end, { desc = 'Telescope Live Grep (changed files)' })
      map({ 'n', 'v' }, '<leader>fs', builtin.grep_string, { desc = 'Telescope Live Grep' })
      map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers' })
      map('n', '<leader>fq', builtin.quickfix, { desc = 'Telescope quickfix' })
      map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
      map('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope Old Files' })
      map('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })
      map('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope Jump List' })
      map('n', '<leader>fM', builtin.marks, { desc = 'Telescope Marks' })
      map('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })
      map('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope man pages' })
      map('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })
      map(
        'n',
        '<leader>fn',
        function() require('telescope').extensions.notify.notify() end,
        { desc = 'Telescope Notifications' }
      )
      map(
        'n',
        '<leader>fd',
        function() builtin.diagnostics({ bufnr = 0, previewer = false }) end,
        { desc = 'Telescope Diagnostics (buffer)' }
      )
      map('n', '<leader>fD', builtin.diagnostics, { desc = 'Telescope Diagnostics (CWD)' })
      map('n', '<leader>fS', builtin.lsp_document_symbols, { desc = 'Telescope LSP Document Symbols' })
      map('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP Workspace Symbols' })
      map('n', '<leader>gF', builtin.git_files, { desc = 'Telescope Git Files' })
      map('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git Status' })
      map('n', 'z=', builtin.spell_suggest, { desc = 'Telescope spell suggest' })
    end,
  },
}
