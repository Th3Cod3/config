local delete_qf_item = require('th3cod3.functions').delete_qf_item

vim.keymap.set('n', 'dd', delete_qf_item, { buffer = true, silent = true })
