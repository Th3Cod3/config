return {
  {
    'williamboman/mason.nvim',
    lazy = true,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependancies = {

      {
        'williamboman/mason-lspconfig.nvim',
        event = 'VeryLazy',
        config = function()
          require('mason-lspconfig').setup({
            ensure_installed = {
              -- terminal&vim
              'lua_ls',
              'bashls',
              'vimls',
              -- embedded
              -- 'asm_lsp', -- requires cargo
              'clangd',
              'vhdl_ls',
              'serve_d',
              -- web
              'ts_ls',
              'eslint',
              'ast_grep',
              'vuels',
              'volar',
              'jsonls',
              'cssls',
              'emmet_ls',
              'html',
              'phpactor',
              'intelephense',
              -- others
              'dockerls',
              'sqlls',
              'yamlls',
              'grammarly',
            },
          })
        end,
      },
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
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
      -- lspconfig.vhdl_ls.setup({ capabilities = capabilities })
      -- lspconfig.serve_d.setup({ capabilities = capabilities })

      -- web
      local mason_registry = require('mason-registry')
      local vuels = mason_registry.get_package('vue-language-server')
      local vue_language_server_path = vuels:get_install_path() .. '/node_modules/@vue/language-server'

      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.ast_grep.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,

        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
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

      lspconfig.volar.setup({
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
      -- lspconfig.grammarly.setup({ capabilities = capabilities })

      vim.keymap.set('n', '<leader>cl', ':LspInfo<cr>', { desc = 'Lsp Info' })
      vim.keymap.set('n', '<leader>ch', ':ClangdSwitchSourceHeader<cr>', { desc = 'Clangd Switch Source Header' })
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
      vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
    end,
  },
}
