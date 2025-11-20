local function decode_url(str)
  return str:gsub('%%(%x%x)', function(h)
    return string.char(tonumber(h, 16))
  end)
end

local function encode_url(str)
  return str:gsub("[^%w-_~%.%!%*'%(%)/]", function(c)
    return string.format('%%%02X', string.byte(c))
  end)
end

local function move_media_and_update_refs()
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
  vim.api.nvim_buf_call(current_buf, function()
    vim.cmd(string.format([[%%s@%s@%s@g]], old_rel, new_rel))
  end)

  vim.notify(string.format('Moved %s → %s and updated references', abs_old_path, new_path))
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.keymap.set(
      'n',
      '<leader>mm',
      move_media_and_update_refs,
      { buffer = true, desc = 'Move file and update references' }
    )
  end,
})
