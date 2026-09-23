vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank({ higroup = 'Visual', timeout = 500 }) end,
})

vim.api.nvim_create_autocmd('BufReadCmd', {
  pattern = {
    '*.avif',
    '*.bmp',
    '*.gif',
    '*.ico',
    '*.jpeg',
    '*.jpg',
    '*.png',
    '*.tif',
    '*.tiff',
    '*.webp',
    '*.pdf',
    '*.doc',
    '*.docx',
    '*.xls',
    '*.xlsx',
    '*.ppt',
    '*.pptx',
    '*.odt',
    '*.ods',
    '*.odp',
  },
  callback = function(args)
    if not require('th3cod3.functions').open_external(args.file) then
      return
    end

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.api.nvim_buf_delete(args.buf, { force = true })
      end
    end)
  end,
})
