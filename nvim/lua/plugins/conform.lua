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
            -- Find project root (nearest folder containing composer.json or .git)
            local marker = vim.fs.find({ 'composer.json', '.git' }, { path = ctx.dirname, upward = true })[1]
            if not marker then
              return false
            end
            local root = vim.fs.dirname(marker)
            -- Only enable if vendor/bin/php-cs-fixer exists
            return vim.fn.filereadable(root .. '/vendor/bin/php-cs-fixer') == 1
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
            local root = vim.fs.dirname(marker)
            return vim.fn.filereadable(root .. '/vendor/bin/pint') == 1
          end,
        },
      },
    },
  },
}
