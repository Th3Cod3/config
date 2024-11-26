return {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'tpope/vim-dotenv',
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'kevinhwang91/promise-async',
    },

    cmd = { 'Laravel' },
    keys = {
      { '<leader>la', ':Laravel artisan<cr>', desc = 'Laravel artisan' },
      { '<leader>lr', ':Laravel routes<cr>', desc = 'Laravel routes' },
      { '<leader>lm', ':Laravel related<cr>', desc = 'Laravel related' },
      { '<leader>ku', ':!docker-compose up<cr>', desc = 'docker-compose up' },
      { '<leader>kd', ':!docker-compose down<cr>', desc = 'docker-compose down' },
      { '<leader>ks', ':!docker-compose stop<cr>', desc = 'docker-compose stop' },
    },

    event = { 'VeryLazy' },
    opts = {
      lsp_server = 'intelephense',
    },
    config = true,
  },
}
