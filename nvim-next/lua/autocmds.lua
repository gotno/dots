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
