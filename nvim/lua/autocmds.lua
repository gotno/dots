-- trim trailing whitespace before writing buffer
vim.api.nvim_create_autocmd(
  'BufWritePre',
  {
    callback = function ()
      local view = vim.fn.winsaveview()
      vim.cmd [[keepp %s/\s\+$//e]]
      -- vim.cmd 'update' -- save if altered
      vim.fn.winrestview(view)
    end
  }
)

