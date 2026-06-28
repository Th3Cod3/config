local minify_markdown_tables = require('th3cod3.functions').minify_markdown_tables

vim.keymap.set('n', '<leader>ms', minify_markdown_tables, {
  buffer = true,
  desc = 'Minify markdown table formatting',
})
