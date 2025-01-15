local M = {}

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
  'grammarly',
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
