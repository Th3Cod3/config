return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = 'VeryLazy',
    opts = {
      ensure_installed = require('config.ensure_installed').null_ls,
    },
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')
      local docker_map_dir = '/var/www/html'
      local function get_docker_path(params)
        ---@type string filename
        local filename = params.bufname
        local project_root = vim.fn.getcwd()

        filename = filename:gsub(vim.pesc(project_root), docker_map_dir)

        return filename
      end

      local h = require('null-ls.helpers')

      null_ls.setup({
        diagnostics_format = '[#{s}] #{m}',
        sources = {
          null_ls.builtins.diagnostics.phpstan.with({
            command = 'docker-compose',
            args = function(params)
              return {
                'exec',
                'web',
                'vendor/bin/phpstan',
                'analyze',
                '--error-format',
                'json',
                '--no-progress',
                get_docker_path(params),
                '--memory-limit=1G',
              }
            end,
            timeout = 5000,
            temp_dir = '/tmp',
            on_output = function(params)
              local path = params.temp_path or params.bufname
              local parser = h.diagnostics.from_json({})

              path = get_docker_path(params)
              params.messages = params.output
                  and params.output.files
                  and params.output.files[path]
                  and params.output.files[path].messages
                or {}

              if not next(params.messages) and not params.output then
                vim.notify('phpstan error: ' .. params.err)
              end

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
                get_docker_path(params),
              }
            end,
            timeout = 5000,
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
