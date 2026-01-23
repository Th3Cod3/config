local map = vim.keymap.set
local opts = { buffer = true, silent = true }

map('n', 'q', '<cmd>q<CR>', opts)
map('n', '<CR>', '<cmd>q<CR>', opts)
map('n', '<esc>', '<cmd>q<CR>', opts)
