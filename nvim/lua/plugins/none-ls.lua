return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      {
        'nvimtools/none-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
      },
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = {
          'stylua',
          'shfmt',
          'blade_formatter',
          'phpcsfixer',
          'prettierd',
          'stylelint',
          'editorconfig_checker',
          'markdownlint',
          'checkmake',
          'phpstan',
          'stylelint',
        },
      })

      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.blade_formatter,
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.sqlfmt,
          null_ls.builtins.formatting.stylelint,
          null_ls.builtins.diagnostics.editorconfig_checker,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.phpstan,
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.todo_comments,
          null_ls.builtins.hover.dictionary,
        },
      })

      vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
    end,
  },
}
