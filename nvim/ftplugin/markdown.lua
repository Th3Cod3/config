local fns = require('th3cod3.functions')
local map = vim.keymap.set

vim.opt_local.wrap = true
vim.opt_local.textwidth = 120

map('n', '<leader>mm', fns.move_media_and_update_refs, { buffer = true, desc = 'Move file and update references' })
map('n', '<leader>ms', fns.minify_markdown_tables, { buffer = true, desc = 'Minify markdown table formatting' })
