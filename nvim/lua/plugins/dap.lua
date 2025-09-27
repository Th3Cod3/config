local function get_visual_expr()
  local bufnr = 0
  local srow, scol = unpack(vim.fn.getpos("'<"), 2, 3) -- 1-based
  local erow, ecol = unpack(vim.fn.getpos("'>"), 2, 3)

  -- normalize order if selection was made backwards
  if erow < srow or (erow == srow and ecol < scol) then
    srow, erow = erow, srow
    scol, ecol = ecol, scol
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, srow - 1, erow, false)
  if #lines == 0 then
    return ''
  end

  -- "v", "V", or "\022" (block)
  local mode = vim.fn.mode()
  if mode == 'V' then
    -- linewise: keep whole lines
  else
    -- charwise: trim first/last line by columns
    local first = lines[1]
    local last = lines[#lines]

    -- defensive bounds
    local function clamp(x, lo)
      return math.max(lo, x)
    end
    local first_from = clamp(scol, 1)
    local last_to = ecol

    if #lines == 1 then
      lines[1] = string.sub(first, first_from, last_to)
    else
      lines[1] = string.sub(first, first_from)
      lines[#lines] = string.sub(last, 1, last_to)
    end
  end

  local expr = table.concat(lines, '\n')
  expr = expr:gsub('^%s+', ''):gsub('%s+$', '')
  return expr
end

return {
  {
    'jbyuki/one-small-step-for-vimkind',
    lazy = true,
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
  },
  {
    'nvim-neotest/nvim-nio',
    lazy = true,
  },
  {
    'jbyuki/one-small-step-for-vimkind',
    lazy = true,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
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
            {
              name = 'PHP XDebug port 9003',
              type = 'php',
              request = 'launch',
              port = 9003,
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
  {
    'mfussenegger/nvim-dap',
    event = 'VeryLazy',
    dependencies = {
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require('dap')
      local dap_ui = require('dapui')
      local widgets = require('dap.ui.widgets')
      local repl = require('dap.repl')
      local map = vim.keymap.set

      dap_ui.setup({
        floating = {
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        layouts = {
          {
            elements = {
              {
                id = 'watches',
                size = 0.25,
              },
              {
                id = 'breakpoints',
                size = 0.25,
              },
            },
            position = 'left',
            size = 40,
          },
        },
      })

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

      --- UI
      map('n', '<leader>df', function()
        widgets.centered_float(widgets.frames)
      end, { noremap = true, desc = 'Debug frames' })
      map('n', '<leader>ds', function()
        widgets.centered_float(widgets.scopes)
      end, { noremap = true, desc = 'Debug scopes' })
      map('n', '<leader>dX', function()
        dap.terminate()
        dap.close()
        dap_ui.close()
      end, { noremap = true, desc = 'Debug stop' })
      map('n', '<leader>dx', dap_ui.toggle, { noremap = true, desc = 'Debug UI open/close' })

      --- Actions
      map('n', '<leader>dh', widgets.hover, { noremap = true, desc = 'Debug hover' })
      map('n', '<leader>dp', widgets.preview, { noremap = true, desc = 'Debug preview' })
      map('n', '<leader>db', dap.toggle_breakpoint, { noremap = true, desc = 'Toggle breakpoint' })
      map('n', '<leader>dB', function()
        local condition = vim.fn.input('Breakpoint condition: ')
        if condition ~= '' then
          dap.set_breakpoint(condition)
        end
      end, { desc = 'DAP: Set conditional breakpoint' })
      map('n', '<leader>dl', function()
        local condition = vim.fn.input('Log point message: ')
        if condition ~= '' then
          dap.set_breakpoint(nil, nil, condition)
        end
      end, { desc = 'DAP: Set logpoint' })
      map('n', '<leader>dr', repl.toggle, { noremap = true, desc = 'Toggle REPL' })
      map('n', '<leader>dL', function()
        widgets.centered_float(widgets.breakpoints)
      end, { desc = 'Debug breakpoints (list)' })
      map('n', '<leader>de', function()
        local w = vim.fn.expand('<cword>')
        if not w:match('^%$') then
          w = '$' .. w
        end
        dap_ui.elements.watches.add(w)
      end, { desc = 'Debug add to watch' })

      --- Stepping
      map('n', '<leader>dc', dap.continue, { noremap = true, desc = 'Debug continue' })
      map('n', '<leader>dn', dap.step_over, { noremap = true, desc = 'Debug step over (next)' })
      map('n', '<leader>di', dap.step_into, { noremap = true, desc = 'Debug step into' })
      map('n', '<leader>do', dap.step_out, { noremap = true, desc = 'Debug step out' })
      map('n', '<leader>dk', dap.up, { noremap = true, desc = 'Debug up' })
      map('n', '<leader>dj', dap.down, { noremap = true, desc = 'Debug down' })

      --- Visual mode
      map('v', '<leader>dr', function()
        repl.open()
        repl.execute(get_visual_expr())
      end, { desc = 'DAP: Execute selection in REPL' })
      map('n', '<leader>dR', dap.restart, { noremap = true, desc = 'Debug restart' })

      local dapBefore = dap.listeners.before
      dapBefore.attach.dapui_config = dap_ui.open
      dapBefore.launch.dapui_config = dap_ui.open
      dapBefore.event_terminated.dapui_config = dap_ui.close
      dapBefore.event_exited.dapui_config = dap_ui.close
    end,
  },
}
