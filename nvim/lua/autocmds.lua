-- briefly highlight yanked text
local highlight_group =
  vim.api.nvim_create_augroup("gtno-yank-highlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

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
