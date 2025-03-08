vim.g.mapleader = ' '

local map = vim.keymap.set

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

-- Search
map(
  'n', '<leader>sw', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = 'Replace word under cursor' }
)
map({ 'n', 'v' }, '<leader>sh', ':noh<cr>', { desc = 'Clear search highlight' })

map({ 'n', 'v' }, '<leader>kv', ':qa!<cr>', { desc = 'Force quit all file (kill vim)' })

-- Macros
map('n', 'q', '<nop>', { noremap = true })
map('n', 'Q', 'q', { noremap = true, desc = 'Record macro' })
map('n', '<M-q>', 'Q', { noremap = true, desc = 'Replay last register' })

-- Quickfix
local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

map('n', '<leader>qt', toggle_quickfix, { desc = "Toggle Quickfix Window" })
map('n', '<leader>qn', ':cnext<cr>', { desc = "Next Quickfix" })
map('n', '<leader>qp', ':cprevious<cr>', { desc = "Previous Quickfix" })

-- rezise windows
map('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true })
map('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true })
map('n', '<M-Up>', ':resize -2<CR>', { silent = true })
map('n', '<M-Down>', ':resize +2<CR>', { silent = true })

-- split panes
map({ 'n', 'v' }, '<leader>|', ':vs<cr>')
map({ 'n', 'v' }, '<leader>-', ':sp<cr>')

-- buffer navigation
map({ 'n', 'v' }, '<leader>bd', ':bd<cr>')
map({ 'n', 'v' }, '<leader>bn', ':bnext<cr>')
map({ 'n', 'v' }, '<leader>bp', ':bprevious<cr>')

