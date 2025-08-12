local function trim_trailing_whitespaces()
  local view = vim.fn.winsaveview()
  vim.cmd [[keepp %s/\s\+$//e]]
  -- vim.cmd "update" -- save if altered
  vim.fn.winrestview(view)
end

vim.api.nvim_create_autocmd("BufWritePre", { callback = trim_trailing_whitespaces })
