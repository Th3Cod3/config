return {
  {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- build = "bundled_build.lua",
    build = 'npm install -g mcp-hub@latest',
    opts = {
      -- use_bundled_binary = true,
      auto_approve = false,
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
          -- keymap = {
          --   accept = false,
          --   accept_word = '<C-L>',
          --   accept_line = '<C-J>',
          --   dismiss = '<C-K>',
          -- },
        },
        filetypes = {
          markdown = true,
        },
      })

      local map = vim.keymap.set

      map('i', '<tab>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
          return '<Ignore>'
        end

        return '<tab>'
      end, { expr = true, noremap = true })

      map('i', '<C-K>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').dismiss()
          return '<Ignore>'
        end

        return '<S-tab>'
      end, { expr = true, noremap = true })

      map('i', '<C-L>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept_word()
          return '<Ignore>'
        end

        return '<C-L>'
      end, { expr = true, noremap = true })

      map('i', '<C-J>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept_line()
          return '<Ignore>'
        end

        return '<C-J>'
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
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'copilot',
      providers = {
        copilot = {
          model = 'claude-sonnet-4',
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_approve = false,
        auto_apply_diff_after_generation = false,
      },
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
          insert = { '<C-c>' },
        },
        sidebar = {
          close = { '<C-c>', 'ZZ' },
          close_form_input = { normal = '<C-c>', insert = '<C-d>' },
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
