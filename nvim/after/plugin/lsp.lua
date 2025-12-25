local ltex_status = true

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
    map('n', '<leader>vs', function()
      ltex_status = not ltex_status
      vim.lsp.enable('ltex', ltex_status)

      if not ltex_status then
        vim.notify('ltex stopped')
        vim.lsp.stop_client(vim.lsp.get_clients({ name = 'ltex' }))
      else
        vim.notify('ltex started')
      end
    end, { desc = 'Stop ltex' })

    map('n', 'gd', function()
      builtin.lsp_definitions({ hidden = true, file_ignore_patterns = {}, no_ignore = true })
    end, { desc = 'Goto Definition' })
    map('n', 'gr', function()
      builtin.lsp_references({ hidden = true, file_ignore_patterns = {}, no_ignore = true })
    end, { desc = 'References' })
    map('n', 'gI', function()
      builtin.lsp_implementations({ hidden = true, file_ignore_patterns = {}, no_ignore = true })
    end, { desc = 'Goto Implementation' })
    map('n', 'gy', function()
      builtin.lsp_type_definitions({ hidden = true, file_ignore_patterns = {}, no_ignore = true })
    end, { desc = 'Goto Type Definition' })
    map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })
    map('n', 'gh', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Hover' })
    map('n', 'gK', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, { desc = 'Signature Help' })
    map('i', '<M-k>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, { desc = 'Signature Help' })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
    map('n', '<leader>cc', vim.lsp.codelens.run, { desc = 'Run Codelens' })
    map('n', '<leader>cC', vim.lsp.codelens.refresh, { desc = 'Refresh & Display Codelens' })
    map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
    map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })
  end,
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

-- local timer = vim.uv.new_timer()
--
-- vim.api.nvim_create_autocmd('CursorHold', {
--   callback = function()
--     if not timer then
--       timer = vim.uv.new_timer()
--       return
--     end
--
--     timer:stop() -- cancel previous
--
--     local buf = vim.api.nvim_get_current_buf()
--     local pos = vim.api.nvim_win_get_cursor(0)
--
--     timer:start(1000, 0, function()
--       vim.schedule(function()
--         if buf ~= vim.api.nvim_get_current_buf() then
--           return
--         end
--
--         local newpos = vim.api.nvim_win_get_cursor(0)
--         if newpos[1] ~= pos[1] or newpos[2] ~= pos[2] then
--           return
--         end
--         vim.diagnostic.open_float(nil, { focusable = false })
--       end)
--     end)
--   end,
-- })
