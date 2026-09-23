local M = {}

local backends = { 'opencode', 'claude' }
local state_file = vim.fs.joinpath(vim.fn.stdpath('state'), 'ai_backends.json')
local cwd = vim.fs.normalize(vim.uv.cwd() or vim.fn.getcwd())
local selections = {}

if vim.fn.filereadable(state_file) == 1 then
  local ok, saved = pcall(vim.json.decode, table.concat(vim.fn.readfile(state_file), '\n'))
  if ok and type(saved) == 'table' then
    selections = saved
  end
end

local current = vim.tbl_contains(backends, selections[cwd]) and selections[cwd] or 'opencode'

function M.get() return current end

function M.is(backend) return current == backend end

function M.set(backend)
  if not vim.tbl_contains(backends, backend) then
    vim.notify('Unknown AI backend: ' .. backend, vim.log.levels.ERROR)
    return
  end

  vim.fn.mkdir(vim.fs.dirname(state_file), 'p')
  selections[cwd] = backend
  vim.fn.writefile({ vim.json.encode(selections) }, state_file)
  current = backend
  vim.notify('AI backend for ' .. cwd .. ' set to ' .. backend .. '. Restart Neovim to apply.')
end

function M.select()
  vim.ui.select(backends, { prompt = 'Select AI backend:' }, function(backend)
    if backend then
      M.set(backend)
    end
  end)
end

vim.api.nvim_create_user_command('AIBackendSelect', function(opts)
  if opts.args == '' then
    M.select()
  else
    M.set(opts.args)
  end
end, {
  nargs = '?',
  complete = function() return backends end,
})

return M
