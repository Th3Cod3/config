local ltex_status = false

return {
  {
    'L3MON4D3/LuaSnip',
    event = 'VeryLazy',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },

  {
    'folke/lazydev.nvim',
    ft = { 'lua' },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = require('th3cod3.config.ensure_installed').lsp,
      })
    end,
  },

  {
    'onsails/lspkind.nvim',
    lazy = true,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'InsertEnter', 'BufReadPre', 'BufNewFile' },
    dependancies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      -- terminal&vim
      vim.lsp.enable({
        'lua_ls',
        'bashls',
        'vimls',
      })

      -- embedded/c/c++
      vim.lsp.enable({
        'clangd',
        'vhdl_ls',
      })
      -- vim.lsp.enable('serve_d')

      -- web
      vim.lsp.enable('ts_ls', false)
      vim.lsp.enable({
        -- 'ast_grep',
        'eslint',
        'vtsls',
        'jsonls',
        'cssls',
        'emmet_ls',
        'html',
        'intelephense',
        -- 'phpactor',
      })

      -- others
      vim.lsp.enable('ltex', ltex_status)
      -- vim.lsp.enable({
      -- 'dockerls',
      -- 'sqlls',
      -- 'yamlls',
      -- })
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim',
              },
            },
          },
        },
      })

      vim.lsp.config('clangd', {
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'h', 'arduino', 'cuda', 'proto' },
      })

      local vuels_path = vim.fn.expand('$MASON/packages/vue-language-server/node_modules/@vue/language-server')
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vuels_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }

      vim.lsp.config('vtsls', {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                vue_plugin,
              },
            },
          },
        },

        filetypes = {
          'typescript',
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
      })
    end,
  },
}
