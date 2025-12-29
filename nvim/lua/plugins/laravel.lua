local goFile = function()
  local filetypes = { 'blade', 'php' }
  local ft = vim.api.nvim_get_option_value('filetype', {})

  local isPhpFile = table.concat(filetypes, ','):find(ft) ~= nil

  if isPhpFile and require('laravel').app('gf').cursor_on_resource() then
    return '<cmd>Laravel gf<CR>'
  end

  return 'gf'
end

return {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'tpope/vim-dotenv',
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'kevinhwang91/promise-async',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'Laravel' },
    ft = { 'php', 'blade' },
    event = {
      'BufEnter composer.json',
    },
    keys = {
      {
        '<leader>ll',
        function()
          Laravel.pickers.laravel()
        end,
        desc = 'Laravel: Open Laravel Picker',
      },
      {
        '<leader>lT',
        function()
          Laravel.commands.run('tinker')
        end,
        desc = 'Laravel: Open Laravel Tinker',
      },
      {
        '<leader>lt',
        function()
          Laravel.run('artisan tinker')
        end,
        desc = 'Laravel: Run Artisan Tinker',
      },
      {
        '<c-g>',
        function()
          Laravel.commands.run('view:finder')
        end,
        desc = 'Laravel: Open View Finder',
      },
      {
        '<leader>la',
        function()
          Laravel.pickers.artisan()
        end,
        desc = 'Laravel: Open Artisan Picker',
      },
      {
        '<leader>lr',
        function()
          Laravel.pickers.routes()
        end,
        desc = 'Laravel: Open Routes Picker',
      },
      {
        '<leader>lh',
        function()
          Laravel.run('artisan docs')
        end,
        desc = 'Laravel: Open Documentation',
      },
      {
        '<leader>lm',
        function()
          Laravel.pickers.make()
        end,
        desc = 'Laravel: Open Make Picker',
      },
      {
        '<leader>lc',
        function()
          Laravel.pickers.commands()
        end,
        desc = 'Laravel: Open Commands Picker',
      },
      {
        '<leader>lo',
        function()
          Laravel.pickers.resources()
        end,
        desc = 'Laravel: Open Resources Picker',
      },
      {
        'gf',
        function()
          local ok, res = pcall(function()
            if Laravel.app('gf').cursorOnResource() then
              return "<cmd>lua Laravel.commands.run('gf')<cr>"
            end
          end)
          if not ok or not res then
            return 'gf'
          end
          return res
        end,
        expr = true,
        noremap = true,
      },
    },

    opts = {
      lsp_server = 'intelephense',
      ui = {
        default = 'popup',
        window = {
          border = 'rounded',
          height = 0.8,
          width = 0.8,
        },
      },
      environments = {
        definitions = {
          {
            name = 'docker-compose',
            map = {
              php = { 'docker', 'compose', 'exec', '-it', 'web', 'php' },
              composer = { 'docker', 'compose', 'exec', '-it', 'web', 'composer' },
              npm = { 'docker', 'compose', 'exec', '-it', 'web', 'npm' },
              yarn = { 'docker', 'compose', 'exec', '-it', 'web', 'yarn' },
            },
          },
        },
      },
      features = {
        pickers = {
          enable = true,
          provider = 'telescope',
        },
      },
    },
  },
}
