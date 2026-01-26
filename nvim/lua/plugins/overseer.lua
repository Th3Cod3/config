return {
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<leader>ro', '<cmd>OverseerToggle<cr>', desc = 'Toggle Overseer' },
      { '<leader>rr', '<cmd>OverseerRun<cr>', desc = 'Run Task' },
      { '<leader>rs', '<cmd>OverseerShow<cr>', desc = 'Show Tasks' },
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
        min_height = 0.5,
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
