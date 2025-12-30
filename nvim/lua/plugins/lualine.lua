return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('laravel') -- ensure laravel is loaded

      require('lualine').setup({
        options = {
          globalstatus = true,
        },

        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = {
            'lsp_status',
            'copilot',
            {
              function()
                local ok, laravel_version = pcall(function()
                  return Laravel.app('status'):get('laravel')
                end)
                if ok then
                  return laravel_version
                end
              end,
              icon = { ' ', color = { fg = '#F55247' } },
              cond = function()
                local ok, has_laravel_versions = pcall(function()
                  return Laravel.app('status'):has('laravel')
                end)
                return ok and has_laravel_versions
              end,
            },
            {
              function()
                local ok, php_version = pcall(function()
                  return Laravel.app('status'):get('php')
                end)
                if ok then
                  return php_version
                end
                return nil
              end,
              icon = { ' ', color = { fg = '#AEB2D5' } },
              cond = function()
                local ok, has_php_version = pcall(function()
                  return Laravel.app('status'):has('php')
                end)
                return ok and has_php_version
              end,
            },
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },
  {
    'AndreM222/copilot-lualine',
  },
}
