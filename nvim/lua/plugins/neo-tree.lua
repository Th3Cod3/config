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
          ['f'] = 'fuzzy_finder',
          ['zo'] = { ntc.neotree_zo, desc = 'fold open' },
          ['zO'] = { ntc.neotree_zO, desc = 'fold open recursively' },
          ['zc'] = { ntc.neotree_zc, desc = 'fold close' },
          ['zC'] = { ntc.neotree_zC, desc = 'fold close recursively' },
          ['za'] = { ntc.neotree_za, desc = 'toggle fold' },
          ['zA'] = { ntc.neotree_zA, desc = 'toggle fold recursively' },
          ['zx'] = { ntc.neotree_zx, desc = 'toggle fold' },
          ['zX'] = { ntc.neotree_zX, desc = 'toggle fold recursively' },
          ['zm'] = { ntc.neotree_zm, desc = 'fold more' },
          ['zM'] = { ntc.neotree_zM, desc = 'fold more recursively' },
          ['zr'] = { ntc.neotree_zr, desc = 'fold less' },
          ['zR'] = { ntc.neotree_zR, desc = 'fold less recursively' },
          ['D'] = { ntc.neotree_diff_files, desc = 'diff files' },
          ['J'] = { ntc.neotree_first_file, desc = 'jump to first file' },
          ['K'] = { ntc.neotree_last_file, desc = 'jump to last file' },
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
