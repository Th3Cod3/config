return {
  {
    'nvim-treesitter/nvim-treesitter',
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
        ensure_installed = {
          -- terminal&vim
          'diff',
          'bash',
          'lua',
          'objdump',
          'strace',
          'tmux',
          'vim',
          'query',
          -- embedded
          'asm',
          'arduino',
          'c',
          'cpp',
          'devicetree',
          'disassembly',
          'doxygen',
          'printf',
          'vhdl',
          -- web
          'css',
          'dockerfile',
          'html',
          'javascript',
          'jsdoc',
          'json',
          'php',
          'phpdoc',
          'scss',
          'twig',
          'typescript',
          'vue',
          'blade',
          -- general
          'csv',
          'ini',
          'python',
          'regex',
          'sql',
          'xml',
          'yaml',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })

      vim.opt.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.opt.foldlevelstart = 99
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependancies = {
      'nvim-treesitter/nvim-treesitter',
    },
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
              ['ap'] = { query = '@parameter.outer', desc = 'Outer parameter' },
              ['ip'] = { query = '@parameter.inner', desc = 'Inner parameter' },
              ['aa'] = { query = '@attribute.outer', desc = 'Outer attribute' },
              ['ia'] = { query = '@attribute.inner', desc = 'Inner attribute' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
}
