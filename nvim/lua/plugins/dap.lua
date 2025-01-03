return {
  {
    'jbyuki/one-small-step-for-vimkind',
  },
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'mason.nvim',
      -- adapters
      'jbyuki/one-small-step-for-vimkind',
      {
        'jay-babu/mason-nvim-dap.nvim',
        opts = {
          ensure_installed = {
            'php',
          },

          handlers = {
            function(config)
              require('mason-nvim-dap').default_setup(config)
            end,

            php = function(config)
              config.configurations = {
                {
                  name = 'PHP XDebug port 9001',
                  type = 'php',
                  request = 'launch',
                  port = 9001,
                  pathMappings = {
                    ['/var/www/html/'] = '${workspaceFolder}',
                  },
                  hostname = '0.0.0.0',
                  ignore = {
                    '**/vendor/**',
                  },
                },
              }

              require('mason-nvim-dap').default_setup(config)
            end,
          },
        },
      },
    },
    config = function()
      local dap = require('dap')
      local dap_ui = require('dapui')

      dap_ui.setup()

      -- dap.configurations.lua = {
      --   {
      --     type = 'nlua',
      --     request = 'attach',
      --     name = 'Attach to running Neovim instance',
      --   },
      -- }

      -- dap.adapters.nlua = function(cb, config)
      --   cb({
      --     type = 'server',
      --     host = config.host or '127.0.0.1',
      --     port = config.port or 8086,
      --   })
      -- end

      local map = vim.keymap.set

      map('n', '<leader>dx', dap.close, { noremap = true, desc = 'Debug close' })
      map('n', '<leader>dX', dap_ui.close, { noremap = true, desc = 'Debug UI close' })
      map('n', '<leader>db', dap.toggle_breakpoint, { noremap = true, desc = 'Toggle breakpoint' })
      map('n', '<leader>dc', dap.continue, { noremap = true, desc = 'Debug continue' })
      map('n', '<leader>dn', dap.step_over, { noremap = true, desc = 'Debug step over (next)' })
      map('n', '<leader>di', dap.step_into, { noremap = true, desc = 'Debug step into' })
      map('n', '<leader>do', dap.step_out, { noremap = true, desc = 'Debug step out' })
      map('n', '<leader>dk', dap.up, { noremap = true, desc = 'Debug up' })
      map('n', '<leader>dj', dap.down, { noremap = true, desc = 'Debug down' })
      map('n', '<leader>dr', dap.repl.toggle, { noremap = true, desc = 'Toggle REPL' })
      map('n', '<leader>dR', dap.restart, { noremap = true, desc = 'Restart debugging' })
      map('n', '<leader>dl', dap.list_breakpoints, { noremap = true, desc = 'List breakpoints' })

      local dapBefore = dap.listeners.before
      dapBefore.attach.dapui_config = dap_ui.open
      dapBefore.launch.dapui_config = dap_ui.open
      dapBefore.event_terminated.dapui_config = dap_ui.close
      dapBefore.event_exited.dapui_config = dap_ui.close
    end,
  },
}
