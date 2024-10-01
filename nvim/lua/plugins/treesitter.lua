return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      -- vim.opt.foldmethod = 'expr'
      -- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      config.setup({
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}
