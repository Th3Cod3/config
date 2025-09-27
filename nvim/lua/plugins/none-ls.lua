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
            command = 'docker',
            args = function(params)
              return {
                'compose',
                'exec',
                '-T',
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
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
            timeout = 10000,
            condition = function(ctx)
              -- Find project root (nearest folder containing composer.json or .git)
              local marker = vim.fs.find({ 'composer.json', '.git' }, { path = ctx.dirname, upward = true })[1]
              if not marker then
                return false
              end
              local root = vim.fs.dirname(marker)
              -- Only enable if vendor/bin/phpstan exists
              return vim.fn.filereadable(root .. '/vendor/bin/phpstan') == 1
            end,
            temp_dir = '/tmp',
            on_exit = function(code, signal, ctx)
              if code ~= 0 then
                -- phpstan returns exit code 1 if any errors are found
                if code == 1 then
                  return
                end
                -- Handle other exit codes (e.g., 2 for configuration errors)
                local err_msg = string.format('phpstan exited with code %d (signal: %d)', code, signal)
                vim.notify(err_msg, vim.log.levels.ERROR)
              end
            end,
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
