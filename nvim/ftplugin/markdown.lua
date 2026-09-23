local markdown = require('th3cod3.markdown')
local map = vim.keymap.set

vim.opt_local.textwidth = 120

map('n', '<leader>mm', markdown.move_media_and_update_refs, { buffer = true, desc = 'Move file and update references' })
map('n', '<leader>ms', markdown.minify_markdown_tables, { buffer = true, desc = 'Minify markdown table formatting' })
map(
  { 'n', 'v' },
  '<leader>mb',
  '<cmd>RenderMarkdown buf_toggle<cr>',
  { buffer = true, desc = 'Toggle Render Markdown Buffer' }
)
map(
  { 'n', 'v' },
  '<leader>mP',
  '<cmd>RenderMarkdown preview<cr>',
  { buffer = true, desc = 'Preview Render Markdown Buffer' }
)
map({ 'n', 'v' }, '<leader>ma', '<cmd>RenderMarkdown expand<cr>', { buffer = true, desc = 'Expand Conceal Markdown' })
map(
  { 'n', 'v' },
  '<leader>mc',
  '<cmd>RenderMarkdown contract<cr>',
  { buffer = true, desc = 'Contract Conceal Markdown' }
)
