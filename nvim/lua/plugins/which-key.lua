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
        { '<leader>t', group = 'Upload / Download', icon = '' },
        {
          '<leader>td',
          '<cmd>TransferDownload<cr>',
          desc = 'Download from remote server (scp)',
          icon = { color = 'green', icon = '󰇚' },
        },
        {
          '<leader>tD',
          '<cmd>DiffRemote<cr>',
          desc = 'Diff file with remote server (scp)',
          icon = { color = 'green', icon = '' },
        },
        {
          '<leader>ti',
          '<cmd>TransferInit<cr>',
          desc = 'Init/Edit Deployment config',
          icon = { color = 'green', icon = '' },
        },
        {
          '<leader>tr',
          '<cmd>TransferRepeat<cr>',
          desc = 'Repeat transfer command',
          icon = { color = 'green', icon = '󰑖' },
        },
        {
          '<leader>tu',
          '<cmd>TransferUpload<cr>',
          desc = 'Upload to remote server (scp)',
          icon = { color = 'green', icon = '󰕒' },
        },
      })
    end,
  },
}
