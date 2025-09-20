return {
  {
    'stevearc/conform.nvim',
    keys = {
      { '<leader>cf', function() require('conform').format() end, desc = 'Format' },
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
        php = { 'phpcsfixer', 'pint', stop_after_first = true },
        python = { 'autoflake', 'black', stop_after_first = true },
      },
      formatters = {
        phpcsfixer = {
          command = 'docker-compose',
          args = {
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
        },
        pint = {
          command = 'docker-compose',
          args = {
            'exec',
            '-T',
            'web',
            'vendor/bin/pint',
            '--no-interaction',
            '--quiet',
            '$RELATIVE_FILEPATH',
          },
          stdin = false,
        },
      },
    },
  },
}
