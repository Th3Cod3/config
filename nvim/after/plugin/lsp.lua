local ltex_status = true

local toggle_ltex = function()
  ltex_status = not ltex_status
  vim.lsp.enable('ltex', ltex_status)

  if not ltex_status then
    vim.notify('ltex stopped')
    vim.lsp.stop_client(vim.lsp.get_clients({ name = 'ltex' }))
  else
    vim.notify('ltex started')
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(mode, keys, func, opts)
      opts = vim.tbl_deep_extend('force', { buffer = event.buf }, opts or {})
      vim.keymap.set(mode, keys, func, opts)
    end

    map('n', '<leader>vs', toggle_ltex, { desc = 'Stop ltex' })

    -- map('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto Definition' })
    -- map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
    -- map('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
    -- map('n', 'gI', vim.lsp.buf.implementation, { desc = 'Goto Implementation' })
    -- map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' })

    map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })
    map('n', 'gh', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })
    map('n', 'gK', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, { desc = 'Signature Help' })
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
    map('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'Run Codelens' })
    map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
    map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
  callback = function() vim.lsp.codelens.enable(true) end,
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
