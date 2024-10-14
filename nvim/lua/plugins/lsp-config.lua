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

      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.vimls.setup({ capabilities = capabilities })
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.serve_d.setup({ capabilities = capabilities })
      lspconfig.intelephense.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'h', 'arduino', 'cuda', 'proto' },
      })

      vim.keymap.set('n', '<leader>cl', '<Cmd>LspInfo<Cr>', { desc = 'Lsp Info' })
      vim.keymap.set('n', '<leader>ch', '<Cmd>ClangdSwitchSourceHeader<Cr>', { desc = 'Clangd Switch Source Header' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
      vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
      vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      vim.keymap.set('i', '<M-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      vim.keymap.set('n', '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
      vim.keymap.set('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
      vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
    end,
  },
}
