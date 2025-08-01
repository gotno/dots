return {
  "stevearc/conform.nvim",
  -- event = { "BufWritePre" },
  -- cmd = { "ConformInfo" },
  keys = {
    {
      '<leader>f',
      function()
        require("conform").format({ async = true }, function(err)
          if not err then
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end
        end)
      end,
      mode = '',
      desc = 'format with conform',
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettierd", stop_after_first = true },
      scss = { "prettierd", stop_after_first = true },
      javascript = { "eslint_d", "eslint-lsp", stop_after_first = true },
      javascriptreact = { "eslint_d", "eslint-lsp", stop_after_first = true },
      typescript = { "eslint_d", "eslint-lsp", stop_after_first = true },
      typescriptreact = { "eslint_d", "eslint-lsp", stop_after_first = true },
    },
    -- Set default options
    -- default_format_opts = {
    --   lsp_format = "fallback",
    -- },
    -- Set up format-on-save
    -- format_on_save = { timeout_ms = 500 },
    -- Customize formatters
    -- formatters = {
    --   shfmt = {
    --     prepend_args = { "-i", "2" },
    --   },
    -- },
  },
  -- init = function()
  --   -- If you want the formatexpr, here is the place to set it
  --   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  -- end,
}
