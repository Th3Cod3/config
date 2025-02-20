local function toggle_telescope(harpoon_files)
  local conf = require('telescope.config').values
  local pickers = require('telescope.pickers')
  local file_paths = {}

  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  pickers
    .new({}, {
      prompt_title = 'Harpoon',
      finder = require('telescope.finders').new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
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

      harpoon:setup()

      local map = vim.keymap.set

      map('n', '<C-h>', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
      map('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Add current file to harpoon' })
      map('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Select harpoon item 1' })
      map('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Select harpoon item 2' })
      map('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Select harpoon item 3' })
      map('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Select harpoon item 4' })
      map('n', '<leader>5', function() harpoon:list():select(5) end, { desc = 'Select harpoon item 5' })
      map('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = 'Previous harpoon item' })
      map('n', '<C-S-N>', function() harpoon:list():next() end, { desc = 'Next harpoon item' })
    end,
  },
}
