vim.cmd('set expandtab')
vim.cmd('set tabstop=2')
vim.cmd('set softtabstop=2')
vim.cmd('set shiftwidth=2')
vim.cmd('set wrap!')
vim.cmd([[ autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup='Visual', timeout=300} ]])

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.listchars = { tab = '» ', trail = '·', lead = '·' }
vim.opt.list = true

vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.updatetime = 50
vim.opt.colorcolumn = '120'
