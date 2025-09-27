return {
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<Esc>',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        mode = 'n',
        desc = 'Dismiss all notifications',
      },
    },
    config = function()
      local notify = require('notify')
      notify.setup({
        max_width = 50,
        max_height = 20,
        background_colour = vim.api.nvim_get_hl(0, { name = "Normal" }).bg or "#000000",
        render = 'minimal',
        timeout = 5000,
        top_down = false,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
        on_close = nil,
      })
      vim.notify = notify
    end,
  },
}
