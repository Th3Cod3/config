return {
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'onsails/lspkind.nvim' },
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<C-J>', '<Plug>(copilot-accept-line)')
      vim.keymap.set('i', '<C-K>', '<Plug>(copilot-dismiss)')
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = 'lazydev', group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer', keyword_length = 5 },
        }),

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              buffer = '[buf]',
              nvim_lsp = '[LSP]',
              nvim_lua = '[api]',
              path = '[path]',
            },
          }),
        },
      })
    end,
  },
}
