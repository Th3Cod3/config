local c = {
  purple = '#5555FF',
  gray = '#999999',
  white = '#CCCCCC',
  gray2 = '#555555',
  yellow = '#999900',
}

return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      local colors = require('cyberdream.colors')
      --- @type cyberdream.Palette
      local p = colors.default

      require('cyberdream').setup({
        transparent = true,
        highlights = {
          Keyword = { fg = p.purple },
          Identifier = { fg = p.cyan },
          Function = { fg = p.purple },
          Type = { fg = p.orange },
          Constant = { fg = p.orange },
          Boolean = { fg = p.orange },

          FloatBorder = { fg = c.white },

          ['@attribute'] = { fg = p.cyan },
          ['@attribute.builtin'] = { fg = p.blue },

          ['@lsp.type.method'] = { fg = c.purple },
          ['@constructor'] = { fg = p.yellow },

          ['@keyword.type'] = { fg = p.purple },
          ['@tag.blade'] = { fg = p.purple },
          ['@punctuation.bracket.blade'] = { fg = p.purple },

          ['@module'] = { fg = c.yellow },
          ['@module.builtin'] = { fg = p.orange },

          ['@function'] = { fg = c.purple },
          ['@function.builtin'] = { fg = p.cyan },
          ['@function.call'] = { fg = p.blue },
          ['@function.macro'] = { fg = p.cyan },
          ['@function.member'] = { fg = c.purple },
          ['@function.method'] = { fg = p.blue },
          ['@function.method.call'] = { fg = p.blue },

          ['@operator'] = { fg = p.pink },

          ['@property'] = { fg = p.cyan },
          ['@property.builtin'] = { fg = p.blue },

          -- Punctuation
          ['@punctuation.bracket'] = { fg = p.grey },
          ['@punctuation.delimiter'] = { fg = p.grey },
          ['@punctuation.special'] = { fg = p.red },

          ['@variable'] = { fg = p.fg },
          ['@variable.builtin'] = { fg = p.red },
          ['@variable.member'] = { fg = p.blue },
          ['@variable.parameter'] = { fg = p.red },
          ['@variable.parameter.builtin'] = { fg = p.orange },

          ['Visual'] = { bg = c.gray2 },
          ['NeoTreeGitModified'] = { fg = p.orange },
        },
      })

      vim.cmd.colorscheme('cyberdream')

      vim.g.terminal_color_8 = '#555555' -- gray
      vim.g.terminal_color_7 = '#AAAAAA' -- light gray

      vim.diagnostic.config({
        float = {
          border = 'rounded',
          source = true,
        },
      })
    end,
  },

  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufEnter' },
    config = function()
      local highlight = {
        'IblRed',
        'IblYellow',
        'IblBlue',
        'IblOrange',
        'IblGreen',
        'IblViolet',
        'IblCyan',
      }

      local hooks = require('ibl.hooks')

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IblRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'IblYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'IblBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'IblOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'IblGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'IblViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'IblCyan', { fg = '#56B6C2' })
      end)

      require('ibl').setup({
        indent = {
          highlight = highlight,
          char = '│',
        },
      })
    end,
  },
}
