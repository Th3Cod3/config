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
      map('n', '<C-S-P>', function() harpoon:list():prev() end, { desc = 'Previous harpoon item' })
      map('n', '<C-S-N>', function() harpoon:list():next() end, { desc = 'Next harpoon item' })
    end,
  },
}
