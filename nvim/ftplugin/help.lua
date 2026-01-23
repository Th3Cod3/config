local map = vim.keymap.set
local opts = { buffer = true, silent = true }

map('n', 'gh', '<C-]>', opts)
map('n', 'gH', '<C-T>', opts)

map('n', 'q', '<cmd>q<CR>', opts)
map('n', '<CR>', '<C-]>', opts)
map('n', 'gr', function()
  local word = vim.fn.expand('<cword>')
  vim.cmd('helpgrep ' .. word)
end, opts)
