-- install with
-- macos `brew install tofu-ls`
-- ubuntu see https://github.com/opentofu/tofu-ls/releases

---@type vim.lsp.Config
return {
  cmd = { 'tofu-ls', 'serve' },
  filetypes = { 'opentofu', 'opentofu-vars', 'terraform' },
  root_markers = { '.terraform', '.git' },
}
