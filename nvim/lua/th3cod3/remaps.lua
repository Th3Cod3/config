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
map('n', '<leader>sw', [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor' })
map({ 'n', 'v' }, '<leader>sh', ':noh<cr>', { desc = 'Clear search highlight' })

map({ 'n', 'v' }, '<leader>kv', ':qa!<cr>', { desc = 'Force quit all file (kill vim)' })

-- Macros
map({ 'n', 'v' }, 'q', '<nop>', { noremap = true })
map('n', 'Q', 'q', { noremap = true, desc = 'Record macro' })
map('n', '<M-q>', 'Q', { noremap = true, desc = 'Replay last register' })

-- Quickfix
local function toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win['quickfix'] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval('&filetype')
  vim.cmd(string.format(
    [[
    execute "\"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end

map('x', '<leader>di', compare_to_clipboard)

local function unique_files_in_quickfix()
  local qflist = vim.fn.getqflist()
  local seen = {}
  local unique_qflist = {}

  for _, item in ipairs(qflist) do
    if not seen[item.bufnr] then
      table.insert(unique_qflist, item)
      seen[item.bufnr] = true
    end
  end

  vim.fn.setqflist({}, ' ', { title = 'Unique Files', items = unique_qflist })
end
map('n', '<leader>qu', unique_files_in_quickfix, { desc = 'Unique Files in Quickfix' })
map('n', '<leader>qt', toggle_quickfix, { desc = 'Toggle Quickfix Window' })
map('n', '<leader>qn', ':cnext<cr>', { desc = 'Next Quickfix' })
map('n', '<leader>qp', ':cprevious<cr>', { desc = 'Previous Quickfix' })

map('t', '<C-q>', [[<C-\><C-n>]], opts)
map('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

---@type 'lines'|'text'|'disabled'
local diagnostic_next_view = 'text'
local function cycle_diagnostic_view()
  if diagnostic_next_view == 'text' then
    diagnostic_next_view = 'lines'
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = true,
    })
  elseif diagnostic_next_view == 'lines' then
    diagnostic_next_view = 'disabled'
    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = false,
    })
  else
    diagnostic_next_view = 'text'
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = false,
    })
  end
end
map('n', '<leader>vd', cycle_diagnostic_view, { desc = 'Cycle Diagnostic View' })

local function diff_register_with_selection()
  if vim.fn.visualmode() == nil then
    return
  end

  vim.cmd('visual! "xy')

  vim.cmd('new')
  vim.cmd('only')
  vim.cmd('put "')
  vim.cmd('diffthis')
  vim.cmd('vnew')
  vim.cmd('put x')
  vim.cmd('diffthis')
end

map('n', '<leader>ti', function()
  local project_init = vim.fn.getcwd() .. '/.nvim/init.lua'
  if vim.fn.filereadable(project_init) == 1 then
    vim.cmd('source ' .. project_init)
    vim.notify('Loaded project init', vim.log.levels.INFO)
  else
    vim.notify('No project '.. project_init .. ' found', vim.log.levels.WARN)
  end
end, { desc = 'Load project init.lua' })

map('v', '<leader>dr', diff_register_with_selection, { desc = 'Diff register with selection' })

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
