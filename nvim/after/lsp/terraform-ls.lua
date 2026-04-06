-- install with
-- macos `brew install terraform-ls`
-- ubuntu see https://www.hashicorp.com/en/official-packaging-guide

---@type vim.lsp.Config
return {
  cmd = { 'terraform-lsp' },
  filetypes = { 'terraform', 'hcl' },
  root_markers = { '.terraform', '.git' },
}
