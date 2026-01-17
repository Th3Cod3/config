local fns = require('th3cod3.functions')
local map = vim.keymap.set

vim.g.mapleader = ' '

-- Move lines
map('v', 'K', ":m '<—2<CR>gv=gv")
map('v', 'J', ":m '>+1<CR>gv=gv")

-- center pane on some movement
map('n', 'J', "mzJ'z")
map('n', '<C—d>', '<C—d>zz')
map('n', '<C—u>', '<C—u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- System clipboard
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', [["+Y]], { desc = 'Yank to system clipboard' })
map({ 'n', 'v' }, '<leader>p', [["+p]], { desc = 'Paste from system clipboard' })
map({ 'n', 'v' }, '<leader>P', [["+P]], { desc = 'Paste from system clipboard' })
map({ 'n', 'v' }, '<leader>x', [["_d]], { desc = 'Delete without yanking' })

-- copy register to system clipboard
map('n', '<leader>cc', [[:let @+ = @"]], { desc = 'Copy current register to system clipboard' })

-- Search
map('n', '<leader>sw', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
map({ 'n', 'v' }, '<leader>sh', ':noh<cr>', { desc = 'Clear search highlight' })

map({ 'n', 'v' }, '<leader>kv', ':qa!<cr>', { desc = 'Force quit all file (kill vim)' })

-- Macros
map({ 'n', 'v' }, 'q', '<nop>', { noremap = true })
map('n', 'Q', 'q', { noremap = true, desc = 'Record macro' })
map('n', '<M-q>', 'Q', { noremap = true, desc = 'Replay last register' })

-- Quickfix
map('x', '<leader>di', fns.compare_to_clipboard)
map('n', '<leader>qu', fns.unique_files_in_quickfix, { desc = 'Unique Files in Quickfix' })
map('n', '<leader>qt', fns.toggle_quickfix, { desc = 'Toggle Quickfix Window' })
map('n', '<leader>qn', ':cnext<cr>', { desc = 'Next Quickfix' })
map('n', '<leader>qp', ':cprevious<cr>', { desc = 'Previous Quickfix' })

-- terminal
map('t', '<C-q>', [[<C-\><C-n>]])
map('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- resize windows
map('n', '<M-H>', '3<C-w><', { silent = true })
map('n', '<M-L>', '3<C-w>>', { silent = true })
map('n', '<M-K>', '3<C-w>-', { silent = true })
map('n', '<M-J>', '3<C-w>+', { silent = true })

-- split panes
map({ 'n', 'v' }, '<leader>|', ':vs<cr>')
map({ 'n', 'v' }, '<leader>-', ':sp<cr>')

-- buffer navigation
map({ 'n', 'v' }, '<leader>bd', ':bd<cr>')
map({ 'n', 'v' }, '<leader>bn', ':bnext<cr>')
map({ 'n', 'v' }, '<leader>bp', ':bprevious<cr>')
map({ 'n', 'v' }, '<leader>bc', ':enew<cr>')

-- custom keymaps
map('n', '<leader><esc>', fns.hide_float_win, { desc = 'Hide floating window' })
map('n', '<leader>vd', fns.cycle_diagnostic_view, { desc = 'Cycle Diagnostic View' })
map('v', '<leader>dr', fns.diff_register_with_selection, { desc = 'Diff register with selection' })
map('n', '<leader>on', fns.open_local_notes_file, { desc = 'Open local notes file' })
map('n', '<leader>ri', fns.load_project_init, { desc = 'Load project init.lua' })
map('n', '<leader>re', fns.open_init_file, { desc = 'Open Neovim init file' })
map('n', 'gx', function() fns.open_url(nil, { under_cursor = true }) end, { desc = 'Open under cursor' })

-- auto commands
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    map('n', 'gh', '<C-]>', opts)
    map('n', 'gH', '<C-T>', opts)

    map('n', 'q', '<cmd>q<CR>', opts)
    map('n', '<CR>', '<C-]>', opts)
    map('n', 'gr', function()
      local word = vim.fn.expand('<cword>')
      vim.cmd('helpgrep ' .. word)
      vim.cmd('copen')
    end, opts)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'notify',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    map('n', 'q', '<cmd>q<CR>', opts)
    map('n', '<CR>', '<cmd>q<CR>', opts)
    map('n', '<esc>', '<cmd>q<CR>', opts)
  end,
})
