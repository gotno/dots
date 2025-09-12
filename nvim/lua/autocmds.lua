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

-- auto-open diagnostic float on lines with diagnostics
vim.api.nvim_create_autocmd(
  { 'CursorHold', 'InsertLeave' },
  {
    callback = function ()
      vim.diagnostic.open_float({
        header = nil,
        scope = 'line',
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter' },
      });
    end,
  }
)
