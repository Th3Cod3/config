vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, keys, func, opts)
      opts = vim.tbl_deep_extend('force', { buffer = event.buf }, opts or {})
      vim.keymap.set(mode, keys, func, opts)
    end

    map('n', '<leader>cl', ':LspInfo<cr>', { desc = 'Lsp Info' })
    map('n', '<leader>ch', ':ClangdSwitchSourceHeader<cr>', { desc = 'Clangd Switch Source Header' })
    -- map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
    -- map('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
    -- map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
    -- map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })
    local builtin = require('telescope.builtin')
    map('n', 'gd', builtin.lsp_definitions, { desc = 'Goto Definition' })
    map('n', 'gr', builtin.lsp_references, { desc = 'References' })
    map('n', 'gI', builtin.lsp_implementations, { desc = 'Goto Implementation' })
    map('n', 'gy', builtin.lsp_type_definitions, { desc = 'Goto Type Definition' })
    map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
    map('n', 'gh', vim.lsp.buf.hover, { desc = 'Hover' })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
    map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
    map('i', '<M-k>', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
    map('n', '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
    map('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
    map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
    map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
  end,
})

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.diagnostic.config({
  virtual_lines = true,
})

-- terminal&vim
vim.lsp.enable('lua_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('vimls')

-- embedded/c/c++
vim.lsp.enable('clangd')
vim.lsp.enable('vhdl_ls')
-- vim.lsp.enable('serve_d')

-- web
vim.lsp.enable('eslint')
-- vim.lsp.enable('ast_grep')
vim.lsp.enable('vtsls')
vim.lsp.enable('jsonls')
vim.lsp.enable('cssls')
vim.lsp.enable('emmet_ls')
vim.lsp.enable('html')
vim.lsp.enable('intelephense')
-- vim.lsp.enable('phpactor')

-- others
vim.lsp.enable('ltex', false)
-- vim.lsp.enable('dockerls')
-- vim.lsp.enable('sqlls')
-- vim.lsp.enable('yamlls')
