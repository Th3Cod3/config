local M = {}

local diff_node = nil
local diff_name = nil

M.find_files = function(state)
  local telescope = require('telescope.builtin')
  local node = state.tree:get_node()
  local path = node:get_id()

  telescope.find_files({ cwd = path, hidden = true })
end

M.live_grep = function(state)
  local telescope = require('telescope.builtin')
  local node = state.tree:get_node()
  local path = node:get_id()

  telescope.live_grep({ cwd = path, hidden = true })
end

M.copy_path = function(state)
  -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
  -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local modify = vim.fn.fnamemodify

  local results = {
    filepath,
    modify(filepath, ':.'),
    modify(filepath, ':~'),
    filename,
    modify(filename, ':r'),
    modify(filename, ':e'),
  }

  vim.ui.select({
    '1. Absolute path: ' .. results[1],
    '2. Path relative to CWD: ' .. results[2],
    '3. Path relative to HOME: ' .. results[3],
    '4. Filename: ' .. results[4],
    '5. Filename without extension: ' .. results[5],
    '6. Extension of the filename: ' .. results[6],
  }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
    if choice then
      local i = tonumber(choice:sub(1, 1))
      if i then
        local result = results[i]
        vim.fn.setreg('"', result)
        vim.fn.setreg('+', result)
        vim.notify('Copied: ' .. result)
      else
        vim.notify('Invalid selection')
      end
    else
      vim.notify('Selection cancelled')
    end
  end)
end

M.neotree_diff_files = function(state)
  local node = state.tree:get_node()
  local log = require('neo-tree.log')
  local render = require('neo-tree.ui.renderer')
  local utils = require('neo-tree.utils')

  state.clipboard = state.clipboard or {}

  if diff_node and diff_node ~= tostring(node.id) then
    local current_diff = node.id
    utils.open_file(state, diff_node)
    vim.cmd('vert diffs ' .. current_diff)
    log.info('Diffing ' .. diff_name .. ' against ' .. node.name)
    diff_node = nil
    current_diff = nil
    state.clipboard = {}
    render.redraw(state)
  else
    local existing = state.clipboard[node.id]

    if existing and existing.action == 'diff' then
      state.clipboard[node.id] = nil
      diff_node = nil
      render.redraw(state)
    else
      state.clipboard[node.id] = { action = 'diff', node = node }
      diff_name = state.clipboard[node.id].node.name
      diff_node = tostring(state.clipboard[node.id].node.id)
      log.info('Diff source file ' .. diff_name)
      render.redraw(state)
    end
  end
end

-- Expand a node and load filesystem info if needed.
local function open_dir(state, dir_node)
  local fs = require('neo-tree.sources.filesystem')
  fs.toggle_directory(state, dir_node, nil, true, false)
end

-- Expand a node and all its children, optionally stopping at max_depth.
local function recursive_open(state, node, max_depth)
  local max_depth_reached = 1
  local stack = { node }

  while next(stack) ~= nil do
    node = table.remove(stack)
    if node.type == 'directory' and not node:is_expanded() then
      open_dir(state, node)
    end

    local depth = node:get_depth()
    max_depth_reached = math.max(depth, max_depth_reached)

    if not max_depth or depth < max_depth - 1 then
      local children = state.tree:get_nodes(node:get_id())
      for _, v in ipairs(children) do
        table.insert(stack, v)
      end
    end
  end

  return max_depth_reached
end

--- Open the fold under the cursor, recursing if count is given.
M.neotree_zo = function(state, open_all)
  local node = state.tree:get_node()

  if open_all then
    recursive_open(state, node)
  else
    recursive_open(state, node, node:get_depth() + vim.v.count1)
  end

  local render = require('neo-tree.ui.renderer')

  render.redraw(state)
end

--- Recursively open the current folder and all folders it contains.
M.neotree_zO = function(state)
  M.neotree_zo(state, true)
end

-- The nodes inside the root folder are depth 2.
local MIN_DEPTH = 2

--- Close the node and its parents, optionally stopping at max_depth.
local function recursive_close(state, node, max_depth)
  if max_depth == nil or max_depth <= MIN_DEPTH then
    max_depth = MIN_DEPTH
  end

  local last = node
  while node and node:get_depth() >= max_depth do
    if node:has_children() and node:is_expanded() then
      node:collapse()
    end
    last = node
    node = state.tree:get_node(node:get_parent_id())
  end

  return last
end

--- Close a folder, or a number of folders equal to count.
M.neotree_zc = function(state, close_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  local max_depth
  if not close_all then
    max_depth = node:get_depth() - vim.v.count1
    if node:has_children() and node:is_expanded() then
      max_depth = max_depth + 1
    end
  end

  local last = recursive_close(state, node, max_depth)
  local render = require('neo-tree.ui.renderer')

  render.redraw(state)
  render.focus_node(state, last:get_id())
end

-- Close all containing folders back to the top level.
M.neotree_zC = function(state)
  M.neotree_zc(state, true)
end

--- Open a closed folder or close an open one, with an optional count.
M.neotree_za = function(state, toggle_all)
  local node = state.tree:get_node()
  if not node then
    return
  end

  if node.type == 'directory' and not node:is_expanded() then
    M.neotree_zo(state, toggle_all)
  else
    M.neotree_zc(state, toggle_all)
  end
end

--- Recursively close an open folder or recursively open a closed folder. M.neotree_zA = function(state) M.neotree_za(state, true)
end

--- Set depthlevel, analagous to foldlevel, for the neo-tree file tree.
local function set_depthlevel(state, depthlevel)
  if depthlevel < MIN_DEPTH then
    depthlevel = MIN_DEPTH
  end

  local stack = state.tree:get_nodes()
  while next(stack) ~= nil do
    local node = table.remove(stack)

    if node.type == 'directory' then
      local should_be_open = depthlevel == nil or node:get_depth() < depthlevel
      if should_be_open and not node:is_expanded() then
        open_dir(state, node)
      elseif not should_be_open and node:is_expanded() then
        node:collapse()
      end
    end

    local children = state.tree:get_nodes(node:get_id())
    for _, v in ipairs(children) do
      table.insert(stack, v)
    end
  end

  vim.b.neotree_depthlevel = depthlevel
end

--- Refresh the tree UI after a change of depthlevel.
-- @bool stay Keep the current node revealed and selected
local function redraw_after_depthlevel_change(state, stay)
  local node = state.tree:get_node()
  local render = require('neo-tree.ui.renderer')

  if stay then
    render.expand_to_node(state.tree, node)
  else
    -- Find the closest parent that is still visible.
    local parent = state.tree:get_node(node:get_parent_id())

    while not parent:is_expanded() and parent:get_depth() > 1 do
      node = parent
      parent = state.tree:get_node(node:get_parent_id())
    end
  end

  render.redraw(state)
  render.focus_node(state, node:get_id())
end

--- Update all open/closed folders by depthlevel, then reveal current node.
M.neotree_zx = function(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, true)
end

--- Update all open/closed folders by depthlevel.
M.neotree_zX = function(state)
  set_depthlevel(state, vim.b.neotree_depthlevel or MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse more folders: decrease depthlevel by 1 or count.
M.neotree_zm = function(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH

  set_depthlevel(state, depthlevel - vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Collapse all folders. Set depthlevel to MIN_DEPTH.
M.neotree_zM = function(state)
  set_depthlevel(state, MIN_DEPTH)
  redraw_after_depthlevel_change(state, false)
end

-- Expand more folders: increase depthlevel by 1 or count.
M.neotree_zr = function(state)
  local depthlevel = vim.b.neotree_depthlevel or MIN_DEPTH

  set_depthlevel(state, depthlevel + vim.v.count1)
  redraw_after_depthlevel_change(state, false)
end

-- Expand all folders. Set depthlevel to the deepest node level.
M.neotree_zR = function(state)
  local top_level_nodes = state.tree:get_nodes()

  local max_depth = 1

  for _, node in ipairs(top_level_nodes) do
    max_depth = math.max(max_depth, recursive_open(state, node))
  end

  vim.b.neotree_depthlevel = max_depth
  redraw_after_depthlevel_change(state, false)
end

M.neotree_first_file = function(state)
  local tree = state.tree
  local node = tree:get_node()
  local siblings = tree:get_nodes(node:get_parent_id())
  local render = require('neo-tree.ui.renderer')

  render.focus_node(state, siblings[#siblings]:get_id())
end

M.neotree_last_file = function(state)
  local tree = state.tree
  local node = tree:get_node()
  local siblings = tree:get_nodes(node:get_parent_id())
  local render = require('neo-tree.ui.renderer')

  render.focus_node(state, siblings[1]:get_id())
end

M.neotree_set_cwd_to_node = function(state)
  if not state then return end

  local node = state.tree:get_node()
  if not node then return end

  local path = node:get_id()
  if not path then return end

  -- If it's a file, go to its parent directory
  if node.type ~= "directory" then
    path = vim.fn.fnamemodify(path, ":h")
  end

  vim.cmd.cd(vim.fn.fnameescape(path))
  vim.notify("cwd → " .. path)
end

return M
