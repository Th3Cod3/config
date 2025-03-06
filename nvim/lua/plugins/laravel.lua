local goFile = function ()
  if require('laravel').app('gf').cursor_on_resource() then
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
