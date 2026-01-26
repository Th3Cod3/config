local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local actionsLayout = require('telescope.actions.layout')
local action_state = require('telescope.actions.state')
local M = {}

M.filesMappings = {
  i = {
    ['<Cr>'] = actions.select_tab,
    ['<C-o>'] = actions.select_default,
    ['<C-b>'] = actions.preview_scrolling_right,
    ['<C-p>'] = actionsLayout.toggle_preview,
    ['<C-j>'] = actions.cycle_history_next,
    ['<C-k>'] = actions.cycle_history_prev,
    ['<C-v>'] = actionsLayout.cycle_layout_next,
  },
  n = {
    ['<Cr>'] = actions.select_tab,
    ['<C-o>'] = actions.select_default,
    ['<C-b>'] = actions.preview_scrolling_right,
    ['<C-p>'] = actionsLayout.toggle_preview,
    ['<C-j>'] = actions.cycle_history_next,
    ['<C-k>'] = actions.cycle_history_prev,

    ['<C-v>'] = actionsLayout.cycle_layout_next,
  },
}

M.man_pages = {
-- 1. User Commands
  section_user_cmds = function() builtin.man_pages({ sections = { '1' } }) end,
-- 2. System Calls
  section_syscall = function() builtin.man_pages({ sections = { '2' } }) end,
  -- 3. Library Functions
  section_lib_fns = function() builtin.man_pages({ sections = { '3' } }) end,
  -- 4. Special Files (usually devices)
  section_special_files = function() builtin.man_pages({ sections = { '4' } }) end,
  -- 5. File Formats and Conventions
  section_file_formats = function() builtin.man_pages({ sections = { '5' } }) end,
  -- 6. Games and Screensavers
  section_games = function() builtin.man_pages({ sections = { '6' } }) end,
  -- 7. Miscellaneous
  section_misc = function() builtin.man_pages({ sections = { '7' } }) end,
  -- 8. System Administration Commands and Daemons
  section_sys_admin = function() builtin.man_pages({ sections = { '8' } }) end,
  -- All Sections
  section_all = function() builtin.man_pages({ sections = { 'ALL' } }) end,
}
M.terminal_picker = function()
  local terminals = {}

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == 'terminal' then
      local bufname = vim.api.nvim_buf_get_name(buf)
      local name = bufname:match('term://.*//(.*)') or bufname
      local cwd = bufname:match('term://(.*)//') or vim.fn.getcwd()

      table.insert(terminals, {
        bufnr = buf,
        bufname = bufname,
        name = name,
        cwd = cwd,
      })
    end
  end

  pickers
    .new({}, {
      prompt_title = 'Terminal Buffers',
      finder = finders.new_table({
        results = terminals,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format('  %d  %s (cwd:%s)', entry.bufnr, entry.name, entry.cwd),
            ordinal = entry.name,
            bufname = entry.name,
            bufnr = entry.bufnr,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.api.nvim_open_win(selection.bufnr, true, {
            relative = 'editor',
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            row = math.floor(vim.o.lines * 0.1),
            col = math.floor(vim.o.columns * 0.1),
            border = 'rounded',
          })
        end)
        map('i', '<C-e>', function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          vim.ui.input(
            { prompt = 'New buffer name: ', default = selection.value.name },
            ---@param name string?
            function(name)
              if name then
                name = 'term://' .. selection.value.cwd .. '//' .. name
                vim.api.nvim_buf_set_name(selection.bufnr, name)
              end
              M.terminal_picker()
            end
          )
        end)
        return true
      end,
    })
    :find()
end

return M
