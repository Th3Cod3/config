return {
  {
    'numToStr/Comment.nvim',
    event = 'BufEnter',
    opts = {},
    config = function(_, opts)
      require('Comment').setup(opts)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'env',
        callback = function() vim.bo.commentstring = '# %s' end,
      })
    end,
  },
}
