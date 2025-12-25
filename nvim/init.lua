local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('th3cod3')

if vim.g.vscode then
  require('lazy').setup('plugins_vscode')
else
  require('lazy').setup('plugins')
end

vim.keymap.set('n', '<leader>L', ':Lazy reload', { desc = 'Lazy reload' })
