return {
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<leader>to', '<cmd>OverseerToggle<cr>', desc = 'Toggle Overseer' },
      { '<leader>tr', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
      { '<leader>ts', '<cmd>OverseerShow<cr>', desc = 'Show Tasks' },
    },
    ---@module 'overseer'
    ---@type overseer.SetupOpts
    opts = {
      form = {
        border = 'rounded',
        max_width = 0.8,
      },
      task_list = {
        border = 'rounded',
        min_height = 0.8,
      },
      output = {
        border = 'rounded',
      },
      task_win = {
        border = 'rounded',
      },
    },
  },
}
