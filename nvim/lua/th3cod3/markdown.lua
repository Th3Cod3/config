local M = {}

local function decode_url(str)
  return str:gsub('%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
end

local function encode_url(str)
  return str:gsub("[^%w-_~%.%!%*'%(%)/]", function(c) return string.format('%%%02X', string.byte(c)) end)
end

M.paste_rich_text_as_markdown = function()
  local types = vim.fn.systemlist({ 'wl-paste', '--list-types' })
  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to inspect clipboard types', vim.log.levels.ERROR)
    return
  end

  local html_type
  local plain_type
  for _, mime_type in ipairs(types) do
    if not html_type and mime_type:match('^text/html') then
      html_type = mime_type
    elseif mime_type == 'text/plain' then
      plain_type = mime_type
    elseif not plain_type and mime_type:match('^text/plain') then
      plain_type = mime_type
    end
  end

  local output
  if html_type then
    local html = vim.fn.system({ 'wl-paste', '--type', html_type })
    if vim.v.shell_error ~= 0 then
      vim.notify('Failed to read HTML from clipboard', vim.log.levels.ERROR)
      return
    end

    output = vim.fn.system({ 'pandoc', '-f', 'html', '-t', 'gfm-raw_html', '--strip-comments' }, html)
  else
    output = vim.fn.system({ 'wl-paste', '--type', plain_type or 'text/plain' })
  end

  if vim.v.shell_error ~= 0 then
    vim.notify('Failed to read or convert clipboard text', vim.log.levels.ERROR)
    return
  end

  output = output:gsub('\n+$', '')
  if output == '' then
    return
  end

  vim.api.nvim_put(vim.split(output, '\n', { plain = true }), 'l', true, true)
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

  local normalized_new_path = new_path:gsub('%s+', '-')
  local abs_new_path = vim.fn.fnamemodify(buf_dir .. '/' .. normalized_new_path, ':p')
  vim.fn.mkdir(vim.fn.fnamemodify(abs_new_path, ':h'), 'p')
  os.rename(abs_old_path, abs_new_path)

  local current_buf = vim.api.nvim_get_current_buf()
  local old_rel = cfile
  local new_rel = encode_url(vim.fn.fnamemodify(normalized_new_path, ':.'))

  vim.notify(string.format('Updating references from %s to %s', old_rel, new_rel))
  vim.api.nvim_buf_call(current_buf, function() vim.cmd(string.format([[%%s@%s@%s@g]], old_rel, new_rel)) end)

  vim.notify(string.format('Moved %s → %s and updated references', abs_old_path, new_path))
end

M.minify_markdown_tables = function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for index, line in ipairs(lines) do
    if line:find('|', 1, true) then
      local cells = vim.split(line, '|', { plain = true })

      for cell_index, cell in ipairs(cells) do
        local trimmed = vim.trim(cell)

        if trimmed == '' and cell:match('%s') then
          cells[cell_index] = ' '
        elseif trimmed:match('^:?-+:?$') then
          local left_align = trimmed:sub(1, 1) == ':'
          local right_align = trimmed:sub(-1) == ':'
          cells[cell_index] = (left_align and ':' or '') .. '---' .. (right_align and ':' or '')
        else
          cells[cell_index] = trimmed
        end
      end

      lines[index] = table.concat(cells, '|')
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

M.open_local_notes_file = function()
  local notes_filename = 'notes.md'
  local notes_dirname = 'notes'
  local notes_project_path = vim.fs.joinpath(vim.fn.getcwd(), '.nvim', notes_dirname, notes_filename)

  if vim.fn.filereadable(notes_project_path) == 0 then
    vim.fn.mkdir(vim.fs.dirname(notes_project_path), 'p')
    vim.fn.writefile({}, notes_project_path)

    vim.fn.writefile({ '# ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'), '' }, notes_project_path, 's')
  end

  local cwd_suffix = vim.fs.joinpath(
    vim.fn.fnamemodify(vim.fs.dirname(vim.fn.getcwd()), ':t'),
    vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  )
  local notes_dir = vim.fs.normalize(vim.fs.joinpath('~/code/Th3Cod3/notes-tech/general/', cwd_suffix))

  if vim.fn.isdirectory(notes_dir) == 0 then
    vim.fn.mkdir(notes_dir, 'p')
    os.execute(
      string.format('ln -sf %s %s', vim.fs.dirname(notes_project_path), vim.fs.joinpath(notes_dir, notes_dirname))
    )
  end

  vim.cmd('edit ' .. notes_project_path)
end

return M
