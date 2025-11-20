return {
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format()
        end,
        desc = 'Format',
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        objc = { 'clang_format' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        vue = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        scss = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        yaml = { 'prettierd', 'prettier', stop_after_first = true },
        sh = { 'shfmt' },
        blade = { 'blade_formatter' },
        php = { 'pint', 'phpcsfixer', stop_after_first = true },
        python = { 'autoflake', 'black', stop_after_first = true },
        sql = { 'sql_formatter' },
        markdown = { 'prettierd', 'prettier', stop_after_first = true },
      },
      formatters = {
        phpcsfixer = {
          command = 'docker',
          args = {
            'compose',
            'exec',
            '-T',
            'web',
            'vendor/bin/php-cs-fixer',
            'fix',
            '--no-interaction',
            '--quiet',
            '$RELATIVE_FILEPATH',
          },
          stdin = false,
          condition = function(ctx)
            local marker = vim.fs.find({ 'composer.json', '.git' }, { path = ctx.dirname, upward = true })[1]
            if not marker then
              return false
            end

            local env_fixer = vim.env.NVIM_PHP_FIXER
            if vim.api.nvim_call_function('exists', { '*DotenvGet' }) == 1 then
              env_fixer = vim.api.nvim_call_function('DotenvGet', { 'NVIM_PHP_FIXER' })
            end

            if vim.fn.empty(env_fixer) == 0 and env_fixer ~= 'phpcs' then
              vim.notify('Skipping phpcsfixer due to NVIM_PHP_FIXER=' .. vim.inspect(env_fixer), vim.log.levels.DEBUG)
              return false
            end

            local root = vim.fs.dirname(marker)
            local has_binary = vim.fn.filereadable(root .. '/vendor/bin/php-cs-fixer') == 1

            if has_binary then
              vim.notify('Using phpcsfixer for PHP formatting', vim.log.levels.DEBUG)
            else
              vim.notify('PHP CS Fixer binary not found, skipping formatter', vim.log.levels.DEBUG)
            end

            return has_binary
          end,
        },
        pint = {
          command = 'docker',
          args = {
            'compose',
            'exec',
            '-T',
            'web',
            'vendor/bin/pint',
            '--config',
            'vendor/webwhales/code-quality-tools/pint.json',
            '--no-interaction',
            '--quiet',
            '$RELATIVE_FILEPATH',
          },
          stdin = false,
          condition = function(ctx)
            local marker = vim.fs.find({ 'composer.json', '.git' }, { path = ctx.dirname, upward = true })[1]
            if not marker then
              return false
            end

            local env_fixer = vim.env.NVIM_PHP_FIXER
            if vim.api.nvim_call_function('exists', { '*DotenvGet' }) == 1 then
              env_fixer = vim.api.nvim_call_function('DotenvGet', { 'NVIM_PHP_FIXER' })
            end

            if vim.fn.empty(env_fixer) == 0 and env_fixer ~= 'pint' then
              vim.notify('Skipping pint due to NVIM_PHP_FIXER=' .. vim.inspect(env_fixer), vim.log.levels.DEBUG)
              return false
            end

            local root = vim.fs.dirname(marker)
            local has_binary = vim.fn.filereadable(root .. '/vendor/bin/pint') == 1

            if has_binary then
              vim.notify('Using pint for PHP formatting', vim.log.levels.DEBUG)
            else
              vim.notify('Pint binary not found, skipping formatter', vim.log.levels.DEBUG)
            end

            return has_binary
          end,
        },
      },
    },
  },
}
