return {
  {
    'sudo-tee/opencode.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>A',
        function()
          local agent = require('opencode.commands.handlers.agent').actions
          agent.switch_mode()
        end,
        desc = 'Opencode: Select Agent',
      },
    },
    config = function()
      require('opencode').setup({
        default_mode = 'plan',
        keymap_prefix = '<leader>a',
        keymap = {
          editor = {
            ['<leader>aa'] = { 'open_input' },
          },
          input_window = {
            ['<esc>'] = false,
            ['<C-r>'] = { 'cycle_variant', mode = { 'n', 'i' } },
          },
          output_window = {
            ['<esc>'] = false,
            ['<C-r>'] = { 'cycle_variant', mode = { 'n', 'i' } },
          },
        },
        ui = {
          window_width = 0.4,
          input = {
            min_height = 0.20,
            max_height = 0.4,
          },
        },
        context = {
          enabled = true, -- Enable automatic context capturing
          cursor_data = {
            enabled = false,
            context_lines = 5,
          },
          diagnostics = {
            enabled = false,
            info = false,
            warning = true,
            error = true,
            only_closest = false,
          },
          current_file = {
            enabled = false,
            show_full_path = false,
          },
          files = {
            enabled = true,
            show_full_path = true,
          },
          selection = {
            enabled = true,
          },
          buffer = {
            enabled = false,
          },
          git_diff = {
            enabled = false,
          },
        },
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      'saghen/blink.cmp',
      'folke/snacks.nvim',
    },
  },
}
