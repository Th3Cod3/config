---@diagnostic disable: missing-fields
return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function()
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = 'https://github.com/EmranMR/tree-sitter-blade',
          files = { 'src/parser.c' },
          branch = 'main',
        },
        filetype = 'blade',
      }

      vim.filetype.add({
        pattern = {
          ['.*%.blade%.php'] = 'blade',
        },
      })

      local config = require('nvim-treesitter.configs')
      config.setup({
        fold = {
          enable = true,
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
        ensure_installed = require('config.ensure_installed').treesitter,
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'BufRead',
    config = function()
      local config = require('nvim-treesitter.configs')

      config.setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = { query = '@function.outer', desc = 'Outer function' },
              ['if'] = { query = '@function.inner', desc = 'Inner function' },
              ['ac'] = { query = '@class.outer', desc = 'Outer class' },
              ['ic'] = { query = '@class.inner', desc = 'Inner class' },
              ['aa'] = { query = '@parameter.outer', desc = 'Outer argument' },
              ['ia'] = { query = '@parameter.inner', desc = 'Inner argument' },
              ['ad'] = { query = '@conditional.outer', desc = 'Outer conditional' },
              ['id'] = { query = '@conditional.inner', desc = 'Inner conditional' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            swap = {
              enable = true,
              swap_next = {
                ['<leader>sa'] = '@parameter.inner',
              },
              swap_previous = {
                ['<leader>sa'] = '@parameter.inner',
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                [']f'] = { query = '@function.outer', desc = 'Next function start' },
                [']d'] = { query = '@conditional.outer', desc = 'Next conditional start' },
                [']]'] = { query = '@class.outer', desc = 'Next class start' },
                [']l'] = { query = { '@loop.inner', '@loop.outer' }, desc = 'Next loop start' },
                [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope' },
                [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
              },
              goto_previous_start = {
                ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
                ['[['] = { query = '@class.outer', desc = 'Previous class start' },
                ['[d'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
                ['[l'] = { query = { '@loop.inner', '@loop.outer' }, desc = 'Previous loop start' },
                ['[s'] = { query = '@local.scope', query_group = 'locals', desc = 'Previous scope' },
                ['[z'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
              },
            },
          },
        },
      })
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    config = function()
      local textobjs = require("various-textobjs")
      textobjs.setup({
        keymaps = {
          useDefaults = true,
        },
      })

      local map = vim.keymap.set
      map({ 'o', 'x' }, 'b', function () textobjs.entireBuffer() end, { noremap = true, silent = true })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependancies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      local ufo = require('ufo')
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      })

      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    end,
  },
}
