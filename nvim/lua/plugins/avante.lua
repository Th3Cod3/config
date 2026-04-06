return {
  {
    'yetone/avante.nvim',
    enabled = false,
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    keys = {
      { '<leader>aC', ':AvanteClear<cr>', desc = 'Avante clear' },
      { '<leader>at', ':AvanteToggle<cr>', desc = 'Avante toggle' },
    },
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'copilot',
      providers = {
        gemini = {
          model = 'gemini-3-flash-preview',
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_approve = false,
        auto_apply_diff_after_generation = false,
        auto_approve_tool_permissions = false,
        confirmation_ui_style = 'popup',
        auto_add_current_file = false,
      },
      windows = {
        width = 50,
        input = {
          height = 15,
        },
      },
      repo_map = {
        ignore_patterns = {
          '%.git',
          '%.worktree',
          '__pycache__',
          'node_modules',
          'vendor',
        },
      },
      mappings = {
        cancel = {
          normal = { '<C-c>' },
          insert = { '<C-c>' },
        },
        sidebar = {
          close = { '<C-c>', 'ZZ' },
          close_form_input = { normal = '<C-c>', insert = '<C-d>' },
        },
      },
      selector = {
        provider = 'snacks',
      },
      system_prompt = function()
        local hub = require('mcphub').get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ''
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      disabled_tools = {
        -- 'attempt_completion',
        -- 'base',
        'bash',
        -- 'create',
        -- 'delete_tool_use_messages',
        'dispatch_agent',
        -- 'edit_file',
        'get_diagnostics',
        -- 'glob',
        -- 'grep',
        -- 'helpers',
        -- 'init',
        -- 'insert',
        -- 'ls',
        -- 'read_todos',
        -- 'replace_in_file',
        -- 'str_replace',
        -- 'think',
        -- 'undo_edit',
        -- 'view',
        -- 'write_to_file',
        -- 'write_todos',
      },
    },
    build = 'make',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-tree/nvim-web-devicons',
      'zbirenbaum/copilot.lua',
      'MeanderingProgrammer/render-markdown.nvim',
      --- The below dependencies may be not needed in my case
      'echasnovski/mini.pick',
      'ibhagwan/fzf-lua',
    },
  },
}
