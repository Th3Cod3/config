local c = {
  purple = '#5555FF',
  gray = '#999999',
  white = '#CCCCCC',
  gray2 = '#555555',
};

return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    name = 'onedark',
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'deep',
        transparent = true,
        highlights = {
          ['@function'] = { fg = c.purple },
          ['@lsp.type.method'] = { fg = c.purple },
          ['@function.member'] = { fg = c.purple },
          ['@variable'] = { fg = c.white },
          ['Visual'] = { bg = c.gray2 },
          ['NeoTreeMessage'] = { fg = c.gray },
          ['NeoTreeFileStats'] = { fg = c.gray },
        },
      })
      require('onedark').load()
    end,
  },

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
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
