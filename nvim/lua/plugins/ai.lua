return {
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- build = "bundled_build.lua",
    -- build = "npm install -g mcp-hub@latest",
    opts = {
      -- use_bundled_binary = true,
      extensions = {
        avante = {
          make_slash_commands = true, -- make /slash commands from MCP server prompts
        },
      },
    },
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = { 'InsertEnter', 'BufRead', 'BufNewFile' },
    keys = {
      { '<leader>ac', ':Copilot suggestion<cr>', desc = 'Copilot suggestion' },
    },
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = false,
            accept_word = '<C-L>',
            accept_line = '<C-J>',
            dismiss = '<C-K>',
          },
        },
        filetypes = {
          markdown = true,
        },
      })

      vim.keymap.set('i', '<tab>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
          return '<Ignore>'
        end

        return '<tab>'
      end, { expr = true, noremap = true })
    end,
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    keys = {
      { '<leader>aC', ':AvanteClear<cr>', desc = 'Avante clear' },
      { '<leader>at', ':AvanteToggle<cr>', desc = 'Avante toggle' },
    },
    opts = {
      provider = 'gemini',
      providers = {
        gemini = {
          model = 'gemini-2.5-flash',
        },
        -- claude = {
        --   endpoint = 'https://api.anthropic.com',
        --   model = 'claude-sonnet-4-20250514',
        --   disable_tools = true,
        --   extra_request_body = {
        --     temperature = 0,
        --     max_tokens = 8192,
        --   },
        -- },
      },
      -- behaviour = {
      --   auto_suggestions = false,
      --   minimize_diff = false,
      --   enable_cursor_planning_mode = true,
      --   enable_claude_text_editor_tool_mode = true,
      -- },
      windows = {
        width = 50,
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
        },
        sidebar = {
          close = { '<C-c>', 'ZZ' },
          close_form_input = { '<C-c>', '<C-d>' },
        },
      },
      selector = {
        provider = 'telescope',
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
        'list_files', -- Built-in file operations
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash', -- Built-in terminal access
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
