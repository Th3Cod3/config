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
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'MunifTanjim/nui.nvim',
    lazy = true,
  },
}
