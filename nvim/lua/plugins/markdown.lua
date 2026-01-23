local map = vim.keymap.set

return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    'hedyhli/markdown-toc.nvim',
    ft = { 'markdown' },
    cmd = { 'Mtoc' },
    config = function()
      require('mtoc').setup({
        toc_list = {
          markers = '-',
        },
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function(event)
          -- keep line
          map('n', '<leader>mt', ':Mtoc<cr>', { desc = 'Markdown TOC', buffer = event.buf })
        end,
      })
    end,
  },

  {
    -- 'iamcco/markdown-preview.nvim',
    'wardenclyffetower/markdown-preview.nvim',
    cmd = {
      'MarkdownPreviewToggle',
      'MarkdownPreview',
      'MarkdownPreviewStop',
    },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function(event)
          map('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc = 'Markdown Preview', buffer = event.buf })
        end,
      })
    end,
  },

  {
    'HakonHarnes/img-clip.nvim',
    opts = {
      default = {
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        -- use_absolute_path = true,
      },
    },
    ft = { 'markdown' },
    cmd = { 'PasteImage' },
    keys = {
      { '<leader>mi', ':PasteImage<cr>', desc = 'Paste Image' },
    },
  },

  {
    'roodolv/markdown-toggle.nvim',
    ft = { 'markdown' },
    opts = {
      use_default_keymaps = false,
      cycle_box_table = true,
      keymaps = {
        toggle = {
          ['<leader>mq'] = 'quote',
          ['<leader>ml'] = 'list',
          ['<leader>mL'] = 'list_cycle',
          ['<leader>mn'] = 'olist',
          ['<leader>mx'] = 'checkbox',
          ['<leader>mh'] = 'heading',
          ['<leader>mH'] = 'heading_toggle',
        },
        switch = {},
        autolist = {},
      },
    },
  },
}
