return {
  {
    'rcarriga/nvim-notify',
    lazy = false,
    keys = {
      {
        '<Esc>',
        function()
          require('notify').dismiss({ silent = true, pending = true })
        end,
        mode = 'n',
        desc = 'Dismiss all notifications',
      },
      {
        '<leader>nl',
        function()
          local notify = require('notify')

          -- Ask user for input
          local input = vim.fn.input('Notify level (e/t/i/w/d): '):lower()

          -- Map both short and long forms
          local map = {
            e = vim.log.levels.ERROR,
            error = vim.log.levels.ERROR,
            w = vim.log.levels.WARN,
            warn = vim.log.levels.WARN,
            i = vim.log.levels.INFO,
            info = vim.log.levels.INFO,
            d = vim.log.levels.DEBUG,
            debug = vim.log.levels.DEBUG,
            t = vim.log.levels.TRACE,
            trace = vim.log.levels.TRACE,
          }

          local level = map[input]
          if not level then
            vim.notify('Invalid level: ' .. input, vim.log.levels.ERROR)
            return
          end

          -- Apply new level
          notify.setup({ level = level })

          local label = ({
            [vim.log.levels.ERROR] = 'ERROR',
            [vim.log.levels.WARN] = 'WARN',
            [vim.log.levels.INFO] = 'INFO',
            [vim.log.levels.DEBUG] = 'DEBUG',
            [vim.log.levels.TRACE] = 'TRACE',
          })[level]

          vim.notify('Notify level → ' .. label, vim.log.levels.INFO)
        end,
        { desc = 'Set notify log level', icon = '🔔' },
      },
    },
    config = function()
      local notify = require('notify')
      notify.setup({
        wrap = true,
        max_width = 50,
        max_height = 20,
        background_colour = '#000000',
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
