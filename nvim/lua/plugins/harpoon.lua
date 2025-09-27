---@param harpoon_files HarpoonList
local function toggle_telescope(harpoon_files)
  local conf = require('telescope.config').values
  local pickers = require('telescope.pickers')

  local entries = {}

  for i, item in ipairs(harpoon_files.items) do
    table.insert(entries, {
      ordinal = string.format('%d: %s', i, item.value),
      display = string.format('%d: %s', i, item.value),
      value = item.value,
      index = i,
    })
  end

  pickers
      .new({}, {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table({
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry.value,
              display = entry.display,
              ordinal = entry.ordinal,
              filename = entry.value,
              index = entry.index,
            }
          end,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          map('i', '<C-D>', function()
            local selection = action_state.get_selected_entry()
            if selection then
              harpoon_files:remove_at(selection.index)
              actions.close(prompt_bufnr)
              toggle_telescope(harpoon_files)
            end
          end, { desc = 'Delete harpoon item' })

          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            harpoon_files:select(selection.index)
          end)
          return true
        end,
      })
      :find()
end

return {
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    branch = 'harpoon2',
    config = function()
      local harpoon = require('harpoon')
      local map = vim.keymap.set

      harpoon:setup()

      map('n', '<C-h>', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
      map('n', '<leader>A', function() harpoon:list():add() end, { desc = 'Add current file to harpoon' })
      map('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Select harpoon item 1' })
      map('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Select harpoon item 2' })
      map('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Select harpoon item 3' })
      map('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Select harpoon item 4' })
      map('n', '<leader>5', function() harpoon:list():select(5) end, { desc = 'Select harpoon item 5' })
      map('n', '<leader>a1', function() harpoon:list():replace_at(1) end, { desc = 'Replace harpoon item 1' })
      map('n', '<leader>a2', function() harpoon:list():replace_at(2) end, { desc = 'Replace harpoon item 2' })
      map('n', '<leader>a3', function() harpoon:list():replace_at(3) end, { desc = 'Replace harpoon item 3' })
      map('n', '<leader>a4', function() harpoon:list():replace_at(4) end, { desc = 'Replace harpoon item 4' })
      map('n', '<leader>a5', function() harpoon:list():replace_at(5) end, { desc = 'Replace harpoon item 5' })
      map('n', '<C-K>', function() harpoon:list():prev() end, { desc = 'Previous harpoon item' })
      map('n', '<C-J>', function() harpoon:list():next() end, { desc = 'Next harpoon item' })
    end,
  },
}
