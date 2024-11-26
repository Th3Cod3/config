vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, '<leader>|', ':s<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>-', ':vs<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>bn', ':bnext<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>bp', ':bprevious<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>bd', ':bd<cr>')

vim.keymap.set('v', 'K', ":m '<—2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ'z")
vim.keymap.set('n', '<C—d>', '<C—d>zz')
vim.keymap.set('n', '<C—u>', '<C—u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', [["+P]], { desc = 'Paste from system clipboard' })

-- vim.keymap.set({ 'n', 'v' }, '<leader><leader>d', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set(
  'n', '<leader>sw', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

vim.keymap.set({ 'n', 'v' }, '<leader>kv', ':qa!<cr>', { desc = 'Force quit all file (quit vim)' })

-- rezise windows
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Down>', ':resize +2<CR>', { silent = true })
