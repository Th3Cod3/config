return {
  {
    'L3MON4D3/LuaSnip',
    event = 'VeryLazy',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },

  {
    'folke/lazydev.nvim',
    ft = { 'lua' },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  {
    'github/copilot.vim',
    event = { 'InsertEnter', 'BufRead', 'BufNewFile' },
    ft = {},
    cmd = { 'Copilot' },
    keys = {
      { '<C-L>', '<Plug>(copilot-accept-word)', desc = 'Copilot accept word', mode = 'i' },
      { '<C-J>', '<Plug>(copilot-accept-line)', desc = 'Copilot accept line', mode = 'i' },
      { '<C-K>', '<Plug>(copilot-dismiss)', desc = 'Copilot dismiss', mode = 'i' },
    },
  },
  { 'hrsh7th/cmp-buffer', event = 'VeryLazy' },
  { 'hrsh7th/cmp-path', event = 'VeryLazy' },
  { 'hrsh7th/cmp-cmdline', event = 'VeryLazy' },
  { 'hrsh7th/cmp-nvim-lua', event = 'VeryLazy' },
  { 'saadparwaiz1/cmp_luasnip', event = 'VeryLazy' },
  {
    'hrsh7th/nvim-cmp',
    event = 'VeryLazy',
    depandancies = {},
    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      cmp.setup({
        snippet = {
          expand = function(args)
            -- vim.snippet.expand(args.body)
            require('luasnip').lsp_expand(args.body)
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
          {
            name = 'nvim_lsp',
            ---@param entry cmp.Entry
            ---@param ctx cmp.Context
            entry_filter = function(entry, ctx)
              -- Check if the buffer type is 'vue'
              if ctx.filetype ~= 'vue' then
                return true
              end

              local cursor_before_line = ctx.cursor_before_line
              -- For events
              if cursor_before_line:sub(-1) == '@' then
                return entry.completion_item.label:match('^@')
                -- For props also exclude events with `:on-` prefix
              elseif cursor_before_line:sub(-1) == ':' then
                return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
              else
                return true
              end
            end,
          },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
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

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline({ ':' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline' },
        },
      })

      local ls = require('luasnip')
      local map = vim.keymap.set

      -- map({ 'i' }, '<cr>', ls.expand, { desc = 'Snippet expand', silent = true })
      map({ 'i', 's' }, '<Tab>', function()
        ls.jump(1)
      end, { desc = 'Snippet jump next', silent = true })
      map({ 'i', 's' }, '<S-Tab>', function()
        ls.jump(-1)
      end, { desc = 'Snippet jump prev', silent = true })

      map({ 'i', 's' }, '<C-E>', function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { desc = 'Snippet change choice', silent = true })
    end,
  },
}
