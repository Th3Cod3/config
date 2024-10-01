return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = { 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim' },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,

      event_handlers = {
        {
          event = 'file_open_requested',
          handler = function()
            vim.cmd('Neotree close')
          end,
        },
      },

      window = {
        position = 'right',
      },

      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = 'A',
            deleted = 'D',
            modified = 'M',
            renamed = 'R',
            -- Status type
            untracked = 'U',
            ignored = 'I',
            unstaged = 'M',
            staged = 'S',
            conflict = 'C',
          },
          align = 'right',
        },

        icon = {
          folder_closed = '/',
          folder_open = '>',
          folder_empty = '-',
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            'node_modules',
            'vendor',
            '.git',
            '.DS_Store',
          },
        },
      },
    })
    vim.keymap.set('n', '<C-e>', ':Neotree filesystem reveal right<CR>', {})
  end,
}
