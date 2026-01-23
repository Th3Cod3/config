return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile', 'BufWritePost' },
    config = function()
      local lint = require('lint')

      lint.linters.phpstan_docker = {
        cmd = 'docker',
        name = 'phpstan_docker',
        args = {
          'compose',
          'exec',
          '-T',
          'web',
          'vendor/bin/phpstan',
          'analyze',
          '--error-format',
          'json',
          '--no-progress',
          function()
            local project_root = vim.fn.getcwd()
            local docker_map_dir = '/var/www/html'
            local bufname = vim.api.nvim_buf_get_name(0)
            local docker_path = bufname:gsub(vim.pesc(project_root), docker_map_dir)

            return docker_path
          end,
          '--memory-limit=1G',
        },
        ignore_exitcode = true,
        append_fname = false,
        stdin = false,
        stream = 'stdout',
        parser = function(output, bufnr)
          if vim.trim(output) == '' or output == nil then
            return {}
          end

          local ok, decoded = pcall(vim.json.decode, output)
          if not ok or not decoded or not decoded.files then
            return {}
          end

          local diagnostics = {}
          local project_root = vim.fn.getcwd()
          local docker_map_dir = '/var/www/html'
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local docker_path = bufname:gsub(vim.pesc(project_root), docker_map_dir)

          local file_messages = decoded.files[docker_path]
          if not file_messages or not file_messages.messages then
            return {}
          end

          for _, msg in ipairs(file_messages.messages) do
            table.insert(diagnostics, {
              lnum = type(msg.line) == 'number' and (msg.line - 1) or 0,
              col = 0,
              message = msg.message,
              code = msg.identifier,
              source = 'phpstan',
            })
          end

          return diagnostics
        end,
      }

      lint.linters_by_ft = {
        php = { 'phpstan_docker' },
        markdown = { 'markdownlint' },
        make = { 'checkmake' },
        ['*'] = { 'editorconfig-checker' },
      }

      -- Custom condition for phpstan to only run if vendor/bin/phpstan exists
      local phpstan_condition = function()
        local marker = vim.fs.find({ 'composer.json', '.git' }, { path = vim.fn.expand('%:p:h'), upward = true })[1]
        if not marker then
          return false
        end
        local root = vim.fs.dirname(marker)
        return vim.fn.filereadable(root .. '/vendor/bin/phpstan') == 1
      end

      -- Set up autocommands to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup('nvim-lint', { clear = true })

      -- For PHP files, only lint on save (performance)
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPre' }, {
        group = lint_augroup,
        pattern = '*.php',
        callback = function()
          if phpstan_condition() then
            lint.try_lint('phpstan_docker')
          end
        end,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.filetype ~= 'php' and vim.bo.buftype ~= 'nofile' then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
