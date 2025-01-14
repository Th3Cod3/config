return {
  { 'jay-babu/mason-null-ls.nvim', lazy = true },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = {
          'stylua',
          'shfmt',
          'blade_formatter',
          'phpcsfixer',
          'prettierd',
          'editorconfig_checker',
          'markdownlint',
          'checkmake',
          'phpstan',
        },
      })

      local null_ls = require('null-ls')

      local docker_map_dir = '/var/www/html'
      local function get_docker_path(params)
        local filename = params.bufname
        local project_root = vim.fn.getcwd()
        return filename:gsub(project_root, docker_map_dir)  -- Replace local root with Docker's path
      end

      local h = require('null-ls.helpers')

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.phpstan.with({
            command = 'docker-compose',
            args =  function(params)
              return {
                'exec',
                'web',
                'vendor/bin/phpstan',
                'analyze',
                '--error-format',
                'json',
                '--no-progress',
                get_docker_path(params)
              }
            end,
            timeout = 50000,
            on_output = function(params)
              local path = params.temp_path or params.bufname
              local parser = h.diagnostics.from_json({})
              path = get_docker_path(params)
              params.messages = params.output
                      and params.output.files
                      and params.output.files[path]
                      and params.output.files[path].messages
                  or {}

              return parser({ output = params.messages })
            end,
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.blade_formatter,
          null_ls.builtins.formatting.phpcsfixer.with({
            command = 'docker-compose',
            args = function(params)
              return {
                'exec',
                'web',
                'vendor/bin/php-cs-fixer',
                '--no-interaction',
                '--quiet',
                'fix',
                get_docker_path(params)
              }
            end,
          }),
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.editorconfig_checker,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.todo_comments,
          null_ls.builtins.hover.dictionary,
        },
      })

      vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, { desc = 'Format with LSP' })
    end,
  },
}
