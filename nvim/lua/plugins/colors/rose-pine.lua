return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup({
      styles = { italic = false },
      highlight_groups = {
        -- GitSignsAdd
        -- GitSignsChange
        -- GitSignsDelete
        -- GitSignsChangedelete
        -- GitSignsTopdelete
        -- GitSignsUntracked
        -- GitSignsStagedAdd
        -- GitSignsStagedChange
        -- GitSignsStagedDelete
        -- GitSignsStagedChangedelete
        -- GitSignsStagedTopdelete
        -- GitSignsStagedUntracked
        Comment = { italic = true }
      },
      -- groups = {
      --   border = "muted",
      --   link = "iris",
      --   panel = "surface",
      --
      --   error = "love",
      --   hint = "iris",
      --   info = "foam",
      --   note = "pine",
      --   todo = "rose",
      --   warn = "gold",
      --
      --   git_add = "foam",
      --   git_change = "rose",
      --   git_delete = "love",
      --   git_dirty = "rose",
      --   git_ignore = "muted",
      --   git_merge = "iris",
      --   git_rename = "pine",
      --   git_stage = "iris",
      --   git_text = "rose",
      --   git_untracked = "subtle",
      --
      --   h1 = "iris",
      --   h2 = "foam",
      --   h3 = "rose",
      --   h4 = "gold",
      --   h5 = "pine",
      --   h6 = "foam",
      -- },
    })
  end
}
