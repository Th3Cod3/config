return {
  {
    'mgierada/lazydocker.nvim',
    dependencies = { 'akinsho/toggleterm.nvim' },
    config = function()
      require('lazydocker').setup({})
    end,
    event = 'BufRead',
    keys = {
      {
        '<leader>ld',
        function()
          require('lazydocker').open()
        end,
        desc = 'Open Lazydocker floating window',
      },
      { '<leader>ku', ':!docker compose up -d<cr>', desc = 'docker compose up' },
      { '<leader>kd', ':!docker compose down<cr>', desc = 'docker compose down' },
      { '<leader>ks', ':!docker compose stop<cr>', desc = 'docker compose stop' },
    },
  },
}
