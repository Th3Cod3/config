return {
  {
    'xiyaowong/transparent.nvim',
    opt = {
      extra_groups = {
        'DiagnosticTextError',
        'DiagnosticTextWarn',
        'DiagnosticTextInfo',
        'DiagnosticTextHint',
      },
    },
  },

  {
    'navarasu/onedark.nvim',
    lazy = false,
    name = 'onedark',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('onedark')
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
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
