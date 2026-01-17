return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    ft = 'markdown',
    cmd = {
      'Obsidian',
    },
    keys = {
      { '<leader>of', '<cmd>Obsidian follow_link<cr>', desc = 'Obsidian: Follow Link' },
      { '<leader>oN', '<cmd>Obsidian new<cr>', desc = 'Obsidian: Create New Note' },
      { '<leader>os', '<cmd>Obsidian search<cr>', desc = 'Obsidian: Search' },
      { '<leader>ot', '<cmd>Obsidian toc<cr>', desc = 'Obsidian: Table of Contents' },
      { '<leader>oT', '<cmd>Obsidian tags<cr>', desc = 'Obsidian: Tags' },
      { '<leader>ol', '<cmd>Obsidian link<cr>', desc = 'Obsidian: Create Link', mode = {'v'} },
      { '<leader>oL', '<cmd>Obsidian links<cr>', desc = 'Obsidian: Links'},
      { '<leader>oi', '<cmd>Obsidian insert_template<cr>', desc = 'Obsidian: Insert Template' },
      { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Obsidian: Backlinks' },
      { '<leader>oe', '<cmd>Obsidian extract_note<cr>', desc = 'Obsidian: Extract Note', mode = {'v'} },
      { '<leader>op', '<cmd>Obsidian paste_img<cr>', desc = 'Obsidian: Paste Image' },
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      preferred_link_style = 'markdown',
      wiki_link_func = nil,
      new_notes_location = 'current_dir',
      workspaces = {
        {
          name = 'notes-tech',
          path = '~/code/Th3Cod3/notes-tech/',
        },
      },
    },
  },
}
