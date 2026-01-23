local move_media_and_update_refs = require('th3cod3.functions').move_media_and_update_refs
local map = vim.keymap.set

vim.opt_local.wrap = true
vim.opt_local.textwidth = 120

map('n', '<leader>mm', move_media_and_update_refs, { buffer = true, desc = 'Move file and update references' })
