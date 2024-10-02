return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'clangd',
          'bashls',
          'vimls',
          'emmet_ls',
          'html',
          'eslint',
          'serve_d',
          'intelephense',
          'vhdl_ls',
        },
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
      })

      lspconfig.vimls.setup({
        capabilities = capabilities,
      })

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
      })

      lspconfig.serve_d.setup({
        capabilities = capabilities,
      })

      lspconfig.intelephense.setup({
        capabilities = capabilities,
      })

      lspconfig.clangd.setup({
        capabilities = capabilities,
        keys = {
          { '<leader>ch', '<Cmd>ClangdSwitchSourceHeader<Cr>', desc = 'Switch Source/Header (C/C++)' },
        },
      })

      vim.keymap.set('n', '<leader>ch', '<Cmd>ClangdSwitchSourceHeader<Cr>', {})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
