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
          keymap = {
            accept = '<M-h>',
            accept_word = '<M-l>',
            accept_line = '<M-j>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<M-k>',
          },
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
}
