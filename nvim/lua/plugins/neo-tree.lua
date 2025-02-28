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
        position = 'current',
        mappings = {
          ['z'] = 'none',
          ['<BS>'] = 'noop',
          ['/'] = 'noop',
          ['U'] = 'navigate_up',
          ['f'] = 'fuzzy_finder',
          ['<C-F>'] = { ntc.find_files, desc = 'Find files (Telescope)' },
          ['<C-G>'] = { ntc.live_grep, desc = 'Live grep (Telescope)' },
          ['Y'] = { ntc.copy_path, desc = 'Copy path' },
          ['zo'] = { ntc.neotree_zo, desc = 'Fold' },
          ['zO'] = { ntc.neotree_zO, desc = 'Fold recursively' },
          ['zc'] = { ntc.neotree_zc, desc = 'Unfold' },
          ['zC'] = { ntc.neotree_zC, desc = 'Unfold recursively' },
          ['za'] = { ntc.neotree_za, desc = 'Toggle fold' },
          ['zA'] = { ntc.neotree_zA, desc = 'Toggle fold recursively' },
          ['zx'] = { ntc.neotree_zx, desc = 'Toggle fold' },
          ['zX'] = { ntc.neotree_zX, desc = 'Toggle fold recursively' },
          ['zm'] = { ntc.neotree_zm, desc = 'Fold more' },
          ['zM'] = { ntc.neotree_zM, desc = 'Fold all' },
          ['zr'] = { ntc.neotree_zr, desc = 'Fold less' },
          ['zR'] = { ntc.neotree_zR, desc = 'Unfold all' },
          ['D'] = { ntc.neotree_diff_files, desc = 'Diff files' },
          ['J'] = { ntc.neotree_first_file, desc = 'Jump to first file' },
          ['K'] = { ntc.neotree_last_file, desc = 'Jump to last file' },
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

    vim.keymap.set('n', '<C-e>', ':Neotree filesystem reveal current<cr>', { desc = 'Reveal in file tree' })
    -- vim.keymap.set('n', '<C-w>', ':Neotree close<CR>', { desc = 'Close file tree' })
  end,
}
