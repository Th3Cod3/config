local startTreesitter = function(buf, lang)
  -- highlights
  local hasStart = pcall(vim.treesitter.start, buf, lang)

  -- indentation
  if hasStart then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  -- fold is managed by nvim-ufo
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    event = 'VeryLazy',
    build = ':TSUpdate',
    keys = {
      { '<leader>tc', ':TSContext toggle<cr>', desc = 'Treesitter: Toggle context' },
      { '<leader>tI', ':Inspect<cr>', desc = 'Treesitter: Inspect node' },
    },
    opts = {
      install_dir = vim.fn.stdpath('data') .. '/treesitter',
    },
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      local parsers = require('nvim-treesitter.parsers')
      local ensureInstalled = require('th3cod3.config.ensure_installed').treesitter

      ts.setup(opts)
      ts.install(ensureInstalled)

      -- auto-start highlights & indentation
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'User: enable treesitter highlighting',
        callback = function(ctx)
          local ft = vim.bo[ctx.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft

          local is_installed = false
          for _, v in ipairs(ts.get_installed()) do
            if v == lang then
              is_installed = true
              break
            end
          end

          -- auto-install parser if not installed
          if not is_installed and parsers[lang] ~= nil then
            vim.notify('Installing treesitter parser for ' .. ft, vim.log.levels.DEBUG, { title = 'TS' })
            ts.install({ ft })

            vim.defer_fn(function()
              vim.notify('Loading treesitter parser for ' .. ft, vim.log.levels.DEBUG, { title = 'TS' })

              startTreesitter(ctx.buf, lang)
            end, 1000)
            return
          end

          startTreesitter(ctx.buf, lang)
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'BufRead',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    init = function() vim.g.no_plugin_maps = true end,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },

        move = {
          set_jumps = true,
        },
      })

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')

      local map_obj = function(key, obj, desc, type)
        type = type or 'textobjects'
        local opts = { noremap = true, silent = true, desc = desc }
        vim.keymap.set({ 'o', 'x' }, key, function() select.select_textobject(obj, type) end, opts)
      end

      local map_next = function(key, obj, desc, type)
        type = type or 'textobjects'
        local opts = { noremap = true, silent = true, desc = desc }
        vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_next_start(obj, type) end, opts)
      end

      local map_prev = function(key, obj, desc, type)
        type = type or 'textobjects'
        local opts = { noremap = true, silent = true, desc = desc }

        vim.keymap.set({ 'n', 'x', 'o' }, key, function() move.goto_previous_start(obj, type) end, opts)
      end

      map_obj('af', '@function.outer', 'Textobj: Outer function')
      map_obj('if', '@function.inner', 'Textobj: Inner function')
      map_obj('ao', '@class.outer', 'Textobj: Outer class')
      map_obj('io', '@class.inner', 'Textobj: Inner class')
      map_obj('aa', '@parameter.outer', 'Textobj: Outer argument')
      map_obj('ia', '@parameter.inner', 'Textobj: Inner argument')
      map_obj('ac', '@conditional.outer', 'Textobj: Outer conditional')
      map_obj('ic', '@conditional.inner', 'Textobj: Inner conditional')

      map_next(']f', '@function.outer', 'Textobj: Next function start')
      map_next(']c', '@conditional.outer', 'Textobj: Next conditional start')
      -- map_next(']]', '@class.outer', 'Textobj: Next class start')
      map_next(']l', { '@loop.inner', '@loop.outer' }, 'Textobj: Next loop start')
      map_next(']s', '@local.scope', 'Textobj: Next scope', 'scopes')
      map_next(']z', '@fold', 'Textobj: Next fold', 'folds')

      map_prev('[f', '@function.outer', 'Textobj: Previous function start')
      -- map_prev('[[', '@class.outer', 'Textobj: Previous class start')
      map_prev('[c', '@conditional.outer', 'Textobj: Previous conditional start')
      map_prev('[l', { '@loop.inner', '@loop.outer' }, 'Textobj: Previous loop start')
      map_prev('[s', '@local.scope', 'Textobj: Previous scope', 'scopes')
      map_prev('[z', '@fold', 'Textobj: Previous fold', 'folds')
    end,
  },
  {
    'chrisgrieser/nvim-various-textobjs',
    event = 'VeryLazy',
    config = function()
      local textobjs = require('various-textobjs')
      textobjs.setup({
        keymaps = {
          useDefaults = true,
        },
      })

      local map = vim.keymap.set
      map({ 'o', 'x' }, 'b', function() textobjs.entireBuffer() end, { noremap = true, silent = true })
    end,
  },
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    config = function()
      local ufo = require('ufo')
      ufo.setup({
        provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
      })

      vim.opt.foldcolumn = '1' -- '0' is not bad
      vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.opt.foldlevelstart = 99
      vim.opt.foldenable = true

      -- Using ufo provider need remap `zR` and `zM`.
      vim.keymap.set('n', 'zR', ufo.openAllFolds)
      vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    end,
  },
}
