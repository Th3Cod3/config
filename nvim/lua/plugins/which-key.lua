return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function() require('which-key').show({ global = false }) end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { 'a', mode = { 'n', 'v' } },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      require('which-key').add({
        { '<leader>u', group = 'Upload / Download', icon = '' },
        {
          '<leader>ud',
          '<cmd>TransferDownload<cr>',
          desc = 'Download from remote server (scp)',
          icon = { color = 'green', icon = '󰇚' },
        },
        {
          '<leader>uf',
          '<cmd>DiffRemote<cr>',
          desc = 'Diff file with remote server (scp)',
          icon = { color = 'green', icon = '' },
        },
        {
          '<leader>ui',
          '<cmd>TransferInit<cr>',
          desc = 'Init/Edit Deployment config',
          icon = { color = 'green', icon = '' },
        },
        {
          '<leader>ur',
          '<cmd>TransferRepeat<cr>',
          desc = 'Repeat transfer command',
          icon = { color = 'green', icon = '󰑖' },
        },
        {
          '<leader>uu',
          '<cmd>TransferUpload<cr>',
          desc = 'Upload to remote server (scp)',
          icon = { color = 'green', icon = '󰕒' },
        },
      })
    end,
  },
}
