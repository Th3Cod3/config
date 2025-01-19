local M = {}

M.treesitter = {
  -- terminal&vim
  'diff',
  'bash',
  'lua',
  'objdump',
  'strace',
  'tmux',
  'vim',
  'query',
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
  'blade',
  -- general
  'csv',
  'ini',
  'python',
  'regex',
  'sql',
  'xml',
  'yaml',
}

M.lsp = {
  -- terminal&vim
  'lua_ls',
  'bashls',
  'vimls',
  -- web
  'ts_ls',
  'eslint',
  'ast_grep',
  'vuels',
  'volar',
  'jsonls',
  'cssls',
  'emmet_ls',
  'html',
  'intelephense',
  -- others
  'dockerls',
  'sqlls',
  'yamlls',
  'ltex',
}

M.null_ls = {
  'stylua',
  'shfmt',
  'blade_formatter',
  'phpcsfixer',
  'prettierd',
  'editorconfig_checker',
  'markdownlint',
  'phpstan',
}

if vim.fn.system('uname -m') == 'x86_64' then
  -- mason has only registered those packages for x86_64
  -- embedded
  table.insert(M.lsp, 'clangd')
  table.insert(M.lsp, 'vhdl_ls')
  table.insert(M.lsp, 'serve_d')
  -- table.insert(M.lsp, 'asm_lsp')
  table.insert(M.null_ls, 'checkmake')
end

return M
