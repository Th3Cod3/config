return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      config.setup({
        ensure_installed = {
          -- terminal&vim
          'diff',
          'bash',
          'lua',
          'objdump',
          'strace',
          'tmux',
          'vim',
          -- embedded
          'asm',
          'arduino',
          'c',
          'cpp',
          'devicetree',
          'disassembly',
          'doxygen',
          'printf',
          'vhdl',
          -- web
          'css',
          'dockerfile',
          'html',
          'javascript',
          'jsdoc',
          'json',
          'php',
          'phpdoc',
          'scss',
          'twig',
          'typescript',
          'vue',
          -- general
          'csv',
          'ini',
          'python',
          'regex',
          'sql',
          'xml',
          'yaml',
        },
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })

    vim.opt.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt.foldlevelstart = 99
    end,
  },
}
