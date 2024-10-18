vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, '<leader>|', ':s<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>-', ':vs<cr>')

vim.keymap.set('v', 'K', ":m '<—2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ'z")
vim.keymap.set('n', '<C—d>', '<C—d>zz')
vim.keymap.set('n', '<C—u>', '<C—u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["*y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["*Y]], { desc = 'Yank to system clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })
vim.keymap.set(
  'n', '<leader>sw', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)

vim.keymap.set({ 'n', 'v' }, '<leader>w', ':w<cr>', { desc = 'Save file' })
vim.keymap.set({ 'n', 'v' }, '<leader>W', ':wa<cr>', { desc = 'Save all files' })
vim.keymap.set({ 'n', 'v' }, '<leader>q', ':q<cr>', { desc = 'Quit file' })
vim.keymap.set({ 'n', 'v' }, '<leader>Q', ':wqa<cr>', { desc = 'Quit all file' })
vim.keymap.set({ 'n', 'v' }, '<leader>kv', ':qa!<cr>', { desc = 'Force quit all file (quit vim)' })

-- rezise windows
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-Up>', ':resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Down>', ':resize +2<CR>', { silent = true })
