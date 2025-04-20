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
    keys = {
      { '<leader>mt', ':Mtoc<cr>', desc = 'Markdown TOC' },
    },
    opts = {},
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = {
      'MarkdownPreviewToggle',
      'MarkdownPreview',
      'MarkdownPreviewStop',
    },
    keys = {
      { '<leader>mp', ':MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' },
    },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
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
    }
  },
}
