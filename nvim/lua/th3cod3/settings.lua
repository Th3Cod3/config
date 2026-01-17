vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
  callback = function() vim.highlight.on_yank({ higroup = 'Visual', timeout = 500 }) end,
})

vim.opt_global.expandtab = true
vim.opt_global.tabstop = 2
vim.opt_global.softtabstop = 2
vim.opt_global.shiftwidth = 2
vim.opt_global.wrap = false
vim.opt_global.smartcase = true
vim.opt_global.ignorecase = true

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.listchars = { tab = '» ', trail = '·', lead = '·' }
vim.opt.list = true

vim.opt.foldcolumn = 'auto:5'
vim.opt.scrolloff = 10
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.updatetime = 50
vim.opt.colorcolumn = '120'
vim.opt.foldlevel = 99

vim.opt.spell = true
vim.opt.spelllang = 'es,nl,en_us'

vim.filetype.add({
  pattern = {
    ['.*%.env.*'] = 'sh',
    ['.*%.ssh/config%.d/.*'] = 'sshconfig',
    ['.*%.blade%.php'] = 'blade',
  },
})
