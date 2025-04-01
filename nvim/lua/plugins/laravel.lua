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
      'nvim-treesitter/nvim-treesitter',
    },
    cmd = { 'Laravel' },
    keys = {
      { '<leader>la', ':Laravel artisan<cr>', desc = 'Laravel artisan' },
      { '<leader>lt', ':Laravel artisan tinker<cr>', desc = 'Laravel Tinker' },
      { '<leader>lr', ':Laravel routes<cr>', desc = 'Laravel routes' },
      { '<leader>lR', ':Laravel related<cr>', desc = 'Laravel related' },
      { '<leader>lv', ':Laravel view_finder<cr>', desc = 'Laravel list views' },
      { '<leader>lm', ':Laravel make<cr>', desc = 'Laravel make' },
      { 'gf', goFile, noremap = false, expr = true, desc = 'Go to file' },
    },
    event = { 'VeryLazy' },
    opts = {
      lsp_server = 'intelephense',
    },
  },
}
