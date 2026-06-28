---@diagnostic disable: missing-fields
local fns = require('th3cod3.functions')
local obsidian_config = require('th3cod3.config.obsidian')

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
      { '<leader>og', '<cmd>Obsidian search<cr>', desc = 'Obsidian: Grep' },
      { '<leader>ot', '<cmd>Obsidian toc<cr>', desc = 'Obsidian: Table of Contents' },
      { '<leader>oT', '<cmd>Obsidian tags<cr>', desc = 'Obsidian: Tags' },
      { '<leader>ol', '<cmd>Obsidian link<cr>', desc = 'Obsidian: Create Link', mode = { 'v' } },
      { '<leader>oL', '<cmd>Obsidian links<cr>', desc = 'Obsidian: Links' },
      { '<leader>oi', obsidian_config.insert_template, desc = 'Obsidian: Insert Template' },
      { '<leader>ob', '<cmd>Obsidian backlinks<cr>', desc = 'Obsidian: Backlinks' },
      { '<leader>oe', '<cmd>Obsidian extract_note<cr>', desc = 'Obsidian: Extract Note', mode = { 'v' } },
      { '<leader>op', '<cmd>Obsidian paste_img<cr>', desc = 'Obsidian: Paste Image' },
      { '<leader>oo', '<cmd>Obsidian quick_switch<cr>', desc = 'Obsidian: Quick Switch' },
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      picker = {
        name = 'snacks.picker',
      },
      templates = {
        enabled = true,
        folder = 'templates',
        date_format = 'YYYY-MM-DD',
        time_format = 'HH:mm',
        substitutions = {
          taskId = function() return fns.buffer_var('taskId') end,
          prNumber = function() return fns.buffer_var('prNumber') end,
          branch = function() return fns.buffer_var('branch') end,
        },
      },
      link = {
        auto_update = true,
        style = 'markdown',
      },
      sync = {
        enabled = true,
        configs = {}, -- explicitly disable .obsidian/*.json syncing
      },
      ui = {
        enabled = false,
        enable = false,
      },
      legacy_commands = false,
      wiki_link_func = nil,
      new_notes_location = 'current_dir',
      workspaces = {
        {
          name = 'notes-tech',
          path = '~/code/Th3Cod3/notes-tech/',
        },
        {
          name = 'no-vault',
          path = function() return assert(vim.fn.getcwd()) end,
          overrides = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            notes_subdir = vim.NIL,
            new_notes_location = 'current_dir',
            frontmatter = {
              enabled = false,
            },
            templates = {
              enabled = true,
              folder = obsidian_config.templates_folder(),
            },
          },
        },
      },
    },
  },
}
