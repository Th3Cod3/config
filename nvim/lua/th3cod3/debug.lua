_G.dump = function(...)
  local objects = vim.tbl_map(vim.inspect, { ... })

  local f = io.open('/tmp/nvim-th3cod3.log', 'a')
  if not f then
    print("Couldn't open file")

    return
  end

  f:write('\n--------------------------------\n')
  for _, object in ipairs(objects) do
    f:write(object)
    f:write('\n############################\n')
  end
  f:write('\n--------------------------------\n')

  f:close()
end

vim.api.nvim_create_user_command('OpenMessages', function()
  vim.cmd('enew')

  vim.cmd([[put =execute('messages')]])

  local opts = {
    bufhidden = 'wipe',
    buftype = 'nofile',
    swapfile = false,
    buflisted = false,
  }
  for k, v in pairs(opts) do
    vim.bo[k] = v
  end

  vim.cmd('0')

  local bufnr = vim.api.nvim_get_current_buf()
  vim.keymap.set('n', '<C-q>', '<cmd>bd!<CR>', {
    buffer = bufnr,
    noremap = true,
    silent = true,
    desc = 'Close this messages buffer',
  })
end, { desc = 'Open the Neovim messages log' })
