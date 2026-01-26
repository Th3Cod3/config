local M = {}

---@type 'lines'|'text'|'disabled'
local diagnostic_next_view = 'text'

M.cycle_diagnostic_view = function()
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

M.cycle_diagnostic_view()

local function decode_url(str)
  return str:gsub('%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
end

local function encode_url(str)
  return str:gsub("[^%w-_~%.%!%*'%(%)/]", function(c) return string.format('%%%02X', string.byte(c)) end)
end

M.move_media_and_update_refs = function()
  local current_buf_path = vim.api.nvim_buf_get_name(0)
  local buf_dir = vim.fn.fnamemodify(current_buf_path, ':h')
  local cfile = vim.fn.expand('<cfile>')
  local cfile_decoded = decode_url(cfile)
  local abs_old_path = vim.fn.fnamemodify(buf_dir .. '/' .. cfile, ':p')
  abs_old_path = decode_url(abs_old_path)

  if abs_old_path == '' then
    vim.notify('No file path under cursor', vim.log.levels.ERROR)
    return
  end

  if vim.fn.filereadable(abs_old_path) == 0 then
    vim.notify('File does not exist or no file path under cursor. ' .. abs_old_path, vim.log.levels.ERROR)
    return
  end

  local new_path = vim.fn.input('Move to: ', cfile_decoded, 'file')
  new_path = decode_url(new_path)
  if new_path == '' then
    return
  end

  -- Move the file
  local normalized_new_path = new_path:gsub('%s+', '-')
  local abs_new_path = vim.fn.fnamemodify(buf_dir .. '/' .. normalized_new_path, ':p')
  vim.fn.mkdir(vim.fn.fnamemodify(abs_new_path, ':h'), 'p')
  os.rename(abs_old_path, abs_new_path)

  -- Update Markdown references in current buffer
  local current_buf = vim.api.nvim_get_current_buf()
  local old_rel = cfile
  local new_rel = encode_url(vim.fn.fnamemodify(normalized_new_path, ':.'))

  vim.notify(string.format('Updating references from %s to %s', old_rel, new_rel))
  vim.api.nvim_buf_call(current_buf, function() vim.cmd(string.format([[%%s@%s@%s@g]], old_rel, new_rel)) end)

  vim.notify(string.format('Moved %s → %s and updated references', abs_old_path, new_path))
end

local function get_url_under_cursor()
  local url = vim.fn.expand('<cfile>')
  if url:match('^https?://') then
    return url
  end
end

--- @type {dirs?: string|string[], bin: string}[]
local browser_dirs_map = {
  {
    dirs = vim.fs.normalize('~/code/WebWhales/'),
    bin = 'google-chrome',
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
        vim.notify('Opening URL with ' .. bin .. ': ' .. url, vim.log.levels.DEBUG)
        vim.system({ bin, url }, { detach = true })
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
  local ftype = vim.api.nvim_eval('&filetype')
  vim.cmd(string.format(
    [[
    execute "\"xy"
    tabnew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    vsplit
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]],
    ftype,
    ftype
  ))
end

M.open_init_file = function()
  local init_file = vim.fn.getcwd() .. '/.nvim/init.lua'

  if vim.fn.filereadable(init_file) == 0 then
    vim.fn.mkdir(vim.fn.getcwd() .. '/.nvim', 'p')
    vim.fn.writefile({}, init_file)
  end

  vim.cmd('edit ' .. init_file)
end

M.open_local_notes_file = function()
  local notes_file = vim.fn.getcwd() .. '/.nvim/notes.md'

  if vim.fn.filereadable(notes_file) == 0 then
    vim.fn.mkdir(vim.fn.getcwd() .. '/.nvim', 'p')
    vim.fn.writefile({}, notes_file)

    vim.fn.writefile({ '# ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'), '' }, notes_file, 's')
  end

  vim.cmd('edit ' .. notes_file)
end

return M
