local M = {}

---@type 'lines'|'text'|'disabled'
local diagnostic_next_view = 'text'

M.copy_to_clipboard = function(value)
  vim.fn.setreg('"', value)
  vim.fn.setreg('+', value)
  vim.notify('Copied: ' .. value, vim.log.levels.DEBUG, { title = 'Git' })
end

M.with_current_branch = function(callback)
  vim.system({ 'git', 'branch', '--show-current' }, nil, function(obj)
    local branch = obj.stdout:gsub('%s+', '')
    if branch == '' then
      vim.notify('No current branch found', vim.log.levels.ERROR, { title = 'Git' })
      return
    end

    callback(branch)
  end)
end

M.with_selected_branch = function(callback)
  local branches = vim.fn.systemlist({ 'git', 'branch', '--format=%(refname:short)' })
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to list branches', vim.log.levels.ERROR, { title = 'Git' })
    return
  end

  if #branches == 0 then
    vim.notify('No branches found', vim.log.levels.ERROR, { title = 'Git' })
    return
  end

  vim.ui.select(branches, { prompt = 'Select branch:' }, function(branch)
    if branch then
      callback(branch)
    end
  end)
end

M.relative_path = function(from, to)
  from = vim.fs.normalize(from):gsub('/$', '')
  to = vim.fs.normalize(to):gsub('/$', '')

  local from_parts = vim.split(from, '/', { plain = true, trimempty = true })
  local to_parts = vim.split(to, '/', { plain = true, trimempty = true })
  local i = 1

  while from_parts[i] and from_parts[i] == to_parts[i] do
    i = i + 1
  end

  local parts = {}
  for _ = i, #from_parts do
    parts[#parts + 1] = '..'
  end

  for j = i, #to_parts do
    parts[#parts + 1] = to_parts[j]
  end

  return #parts > 0 and table.concat(parts, '/') or '.'
end

M.buffer_var = function(name)
  local pattern = '^' .. vim.pesc(name) .. ':%s*(.+)$'
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for _, line in ipairs(lines) do
    local value = line:match(pattern)
    if value then
      return vim.trim(value)
    end
  end

  return ''
end

M.cycle_diagnostic_view = function()
  if diagnostic_next_view == 'text' then
    diagnostic_next_view = 'lines'
    vim.diagnostic.config({
      virtual_lines = false,
      virtual_text = {
        source = true,
      },
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

M.cycle_diagnostic_view()

local function get_url_under_cursor()
  local url = vim.fn.expand('<cfile>')
  if url:match('^https?://') then
    return url
  end
end

M.open_external = function(path)
  if vim.fn.executable('xdg-open') == 0 then
    vim.notify('xdg-open is not available', vim.log.levels.ERROR)
    return false
  end

  vim.system({ 'xdg-open', vim.fs.normalize(path) }, { detach = true })
  return true
end

--- @type {dirs?: string|string[], bin: string, args?: string[]}[]
local browser_dirs_map = {
  {
    dirs = vim.fs.normalize('~/code/WebWhales/'),
    bin = 'flatpak',
    args = { 'run', 'com.google.Chrome' },
  },
}

local function starts_with(s, prefix) return s:sub(1, #prefix) == prefix end

--- @class OpenUrlOptions
--- @field fallback? string (default: "<Cmd>call netrw#BrowseX(expand('<cfile>'), 0)<CR>")
--- @field under_cursor? boolean only attempt to get URL under cursor if url is nil (default: false)

--- @param url string|nil
--- @param opts? OpenUrlOptions
--- @return string|nil
M.open_url = function(url, opts)
  opts = opts or {}
  local fallback = opts.fallback or "<Cmd>call netrw#BrowseX(expand('<cfile>'), 0)<CR>"

  if not url and opts.under_cursor then
    url = get_url_under_cursor()
  end

  if not url then
    return fallback
  end

  local cwd = vim.uv.cwd() or vim.api.nvim_buf_get_name(0)
  if not cwd then
    return fallback
  end
  cwd = vim.fs.normalize(cwd) .. '/'

  for _, map in ipairs(browser_dirs_map) do
    local bin = map.bin
    if not bin or bin == '' then
      vim.notify('No browser binary specified in map', vim.log.levels.WARN)
      goto continue_map
    end

    if vim.fn.executable(bin) == 0 then
      vim.notify('Browser executable not found: ' .. bin, vim.log.levels.WARN)
      goto continue_map
    end

    local dirs = map.dirs
    if not dirs then
      goto continue_map
    end

    if type(dirs) == 'string' then
      dirs = { dirs }
    end

    for _, dir in ipairs(dirs) do
      dir = vim.fs.normalize(dir)

      if dir:sub(-1) ~= '/' then
        dir = dir .. '/'
      end

      if starts_with(cwd, dir) then
        local cmd = { bin }

        if map.args then
          vim.list_extend(cmd, map.args)
        end

        table.insert(cmd, url)

        vim.notify('Opening URL with ' .. table.concat(cmd, ' '), vim.log.levels.DEBUG)
        vim.system(cmd, { detach = true })
        return
      end
    end

    ::continue_map::
  end

  if vim.fn.executable('xdg-open') == 1 then
    vim.notify('Opening URL with xdg-open: ' .. url, vim.log.levels.DEBUG)
    vim.system({ 'xdg-open', url }, { detach = true })
    return
  end

  return fallback
end

M.load_project_init = function()
  local project_init = vim.fn.getcwd() .. '/.nvim/init.lua'
  if vim.fn.filereadable(project_init) == 1 then
    vim.cmd('source ' .. project_init)
    vim.notify('Loaded project init', vim.log.levels.INFO)
  else
    vim.notify('No project ' .. project_init .. ' found', vim.log.levels.WARN)
  end
end

M.diff_register_with_selection = function()
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

M.delete_qf_item = function()
  local qf = vim.fn.getqflist()
  local idx = vim.fn.line('.') - 1

  table.remove(qf, idx + 1)
  vim.fn.setqflist(qf, 'r')
end

M.unique_files_in_quickfix = function()
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

M.hide_float_win = function()
  local win = vim.api.nvim_get_current_win()
  if vim.api.nvim_win_get_config(win).relative ~= '' then
    vim.api.nvim_win_hide(win)
  end
end

M.toggle_quickfix = function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win['quickfix'] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

M.compare_to_clipboard = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local ftype = vim.bo.filetype
  local mode = vim.fn.visualmode()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_row = start_pos[2] - 1
  local start_col = start_pos[3] - 1
  local end_row = end_pos[2] - 1
  local end_col = end_pos[3]

  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  local selected_lines
  if mode == 'V' then
    selected_lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, false)
  else
    selected_lines = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})
  end

  if #selected_lines == 0 then
    vim.notify('No selected text to compare', vim.log.levels.ERROR)
    return
  end

  local clipboard_lines = vim.split(vim.fn.getreg('+'), '\n', { plain = true })

  local function setup_diff_buffer(name, lines)
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].swapfile = false
    vim.bo[buf].filetype = ftype
    vim.api.nvim_buf_set_name(buf, name .. '://' .. buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.cmd.diffthis()
  end

  vim.cmd.tabnew()
  setup_diff_buffer('clipboard', clipboard_lines)
  vim.cmd.vsplit()
  vim.cmd.enew()
  setup_diff_buffer('selection', selected_lines)
end

M.open_init_file = function()
  local init_file = vim.fn.getcwd() .. '/.nvim/init.lua'

  if vim.fn.filereadable(init_file) == 0 then
    vim.fn.mkdir(vim.fn.getcwd() .. '/.nvim', 'p')
    vim.fn.writefile({}, init_file)
  end

  vim.cmd('edit ' .. init_file)
end

return M
