local M = {}
local fns = require('th3cod3.functions')

function M.templates_folder()
  return fns.relative_path(vim.fn.getcwd(), vim.fn.expand('~/code/Th3Cod3/notes-tech/templates'))
end

local builtin_template_vars = {
  date = true,
  time = true,
  title = true,
  id = true,
  path = true,
}

local function template_vars(template_path)
  local ok, lines = pcall(vim.fn.readfile, template_path)
  if not ok then
    vim.notify('Failed to read template: ' .. template_path, vim.log.levels.ERROR, { title = 'Obsidian' })
    return {}
  end

  local vars = {}
  local seen = {}

  for _, line in ipairs(lines) do
    for raw_var in line:gmatch('{{%s*([^}:]+)%s*:?[^}]*}}') do
      local var = vim.trim(raw_var)
      if var ~= '' and not builtin_template_vars[var] and not seen[var] then
        seen[var] = true
        vars[#vars + 1] = var
      end
    end
  end

  return vars
end

local function insert_template_vars(template_path, location)
  local vars = template_vars(template_path)
  if #vars == 0 then
    vim.notify('No custom template variables found', vim.log.levels.INFO, { title = 'Obsidian' })
    return
  end

  local lines = {}
  for _, var in ipairs(vars) do
    lines[#lines + 1] = var .. ': '
  end

  local buf, _, row = unpack(location)
  vim.api.nvim_buf_set_lines(buf, row - 1, row - 1, false, lines)
end

function M.insert_template()
  local api = require('obsidian.api')
  local workspace = api.find_workspace(vim.api.nvim_buf_get_name(0))
  if workspace and workspace.name ~= Obsidian.workspace.name then
    require('obsidian.workspace').set(workspace)
  end

  local templates_dir = api.templates_dir()
  if not templates_dir then
    vim.notify('Templates folder is not defined or does not exist', vim.log.levels.ERROR, { title = 'Obsidian' })
    return
  end

  local insert_location = api.get_active_window_cursor_location()
  local templates = require('obsidian.templates')
  local entries = {}

  for path in api.dir(tostring(templates_dir)) do
    entries[#entries + 1] = {
      filename = path,
      text = vim.fs.basename(path),
    }
  end

  Obsidian.picker.pick(entries, {
    selection_mappings = {
      ['<c-f>'] = {
        desc = 'Insert template variables',
        callback = function(entry) insert_template_vars(entry.filename, insert_location) end,
      },
    },
    callback = function(entry)
      templates.insert_template({
        type = 'insert_template',
        template_name = entry.filename,
        templates_dir = templates_dir,
        location = insert_location,
      })
    end,
  })
end

return M
