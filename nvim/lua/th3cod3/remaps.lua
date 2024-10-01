vim.g.mapleader = ' '

vim.keymap.set({ 'n', 'v' }, '<leader>l', ':s')
vim.keymap.set({ 'n', 'v' }, '<leader>—', ':vs')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<—2<CR>gv=gv")

vim.keymap.set('n', 'J', "mzJ'z")
vim.keymap.set('n', '<C—d>', '<C—d>zz')
vim.keymap.set('n', '<C—u>', '<C—u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- next greatest remap ever 2 asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["*y]])
vim.keymap.set('n', '<leader>Y', [["*Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', '<leader>sw', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set({ 'n', 'v' }, '<leader>w', ':w<cr>')

-- rezise windows
vim.keymap.set('n', '<M-Left>', '<Cmd>vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Right>', '<Cmd>vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-Up>', '<Cmd>resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-Down>', '<Cmd>resize +2<CR>', { silent = true })
