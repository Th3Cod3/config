return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = require('config.ensure_installed').lsp,
      })
    end,
  },

  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = true,
  },

  {
    'onsails/lspkind.nvim',
    lazy = true,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'InsertEnter' },
    dependancies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      vim.diagnostic.config({
        virtual_lines = true,
      })
      -- vim.lsp.set_log_level('debug')

      -- terminal&vim
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.vimls.setup({ capabilities = capabilities })

      -- embedded
      -- lspconfig.asm_lsp.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'h', 'arduino', 'cuda', 'proto' },
      })
      lspconfig.vhdl_ls.setup({ capabilities = capabilities })
      -- lspconfig.serve_d.setup({ capabilities = capabilities })

      -- web
      local vuels_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.ast_grep.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,

        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vuels_path,
              languages = { 'vue' },
            },
          },
        },

        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
      })

      lspconfig.vuels.setup({
        init_options = {
          vue = {
            hybridMode = false,
          },

          typescript = {
            tsdk = '/usr/local/lib/node_modules/typescript/lib',
          },
        },
      })

      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      -- lspconfig.phpactor.setup({ capabilities = capabilities })
      lspconfig.intelephense.setup({ capabilities = capabilities })

      -- others
      -- lspconfig.dockerls.setup({ capabilities = capabilities })
      -- lspconfig.sqlls.setup({ capabilities = capabilities })
      -- lspconfig.yamlls.setup({ capabilities = capabilities })
      lspconfig.ltex.setup({ capabilities = capabilities })

      local builtin = require('telescope.builtin')
      local map = vim.keymap.set

      map('n', '<leader>cl', ':LspInfo<cr>', { desc = 'Lsp Info' })
      map('n', '<leader>ch', ':ClangdSwitchSourceHeader<cr>', { desc = 'Clangd Switch Source Header' })
      map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
      map('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
      map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
      map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })
      -- map('n', 'gd', builtin.lsp_definitions, { desc = 'Goto Definition' })
      -- map('n', 'gr', builtin.lsp_references, { desc = 'References' })
      -- map('n', 'gI', builtin.lsp_implementations, { desc = 'Goto Implementation' })
      -- map('n', 'gy', builtin.lsp_type_definitions, { desc = 'Goto Type Definition' })
      map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
      map('n', 'gh', vim.lsp.buf.hover, { desc = 'Hover' })
      map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
      map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      map('i', '<M-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
      map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
      map('n', '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
      map('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
      map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
      map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
    end,
  },
}
