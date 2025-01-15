return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  priority = 1000,
  config = function()
    local ntc = require('config.neo-tree')
    require('neo-tree').setup({
      event_handlers = {
        {
          event = 'file_open_requested',
          handler = function()
            require('neo-tree.command').execute({ action = 'close' })
          end,
        },
      },

      window = {
        position = 'right',
        mappings = {
          ['z'] = 'none',
          ['<BS>'] = 'noop',
          ['/'] = 'noop',
          ['U'] = 'navigate_up',
          ['zo'] = ntc.neotree_zo,
          ['zO'] = ntc.neotree_zO,
          ['zc'] = ntc.neotree_zc,
          ['zC'] = ntc.neotree_zC,
          ['za'] = ntc.neotree_za,
          ['zA'] = ntc.neotree_zA,
          ['zx'] = ntc.neotree_zx,
          ['zX'] = ntc.neotree_zX,
          ['zm'] = ntc.neotree_zm,
          ['zM'] = ntc.neotree_zM,
          ['zr'] = ntc.neotree_zr,
          ['zR'] = ntc.neotree_zR,
          ['D'] = ntc.neotree_diff_files,
          ['J'] = ntc.neotree_first_file,
          ['K'] = ntc.neotree_last_file,
        },
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
          -- hide_gitignored = false,

          hide_by_name = {
            '.cache',
            '.vscode',
            'node_modules',
            'vendor',
            '.git',
            '.DS_Store',
          },

          always_show_by_pattern = {
            '.env*',
          },
        },
      },
    })

    vim.keymap.set('n', '<C-e>', ':Neotree filesystem reveal right<CR>', { desc = 'Reveal in file tree' })
    -- vim.keymap.set('n', '<C-w>', ':Neotree close<CR>', { desc = 'Close file tree' })
  end,
}
