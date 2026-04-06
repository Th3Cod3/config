local ensure_installed = require('th3cod3.config.ensure_installed')
return {
  {
    'williamboman/mason.nvim',
    lazy = true,
    cmd = {
      'Mason',
      'MasonUpdate',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog',
    },
    opts = {},
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = ensure_installed.null_ls,
      run_on_start = false,
      auto_update = false,
    },
  },

  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },

  {
    'MunifTanjim/nui.nvim',
    lazy = true,
  },
}
