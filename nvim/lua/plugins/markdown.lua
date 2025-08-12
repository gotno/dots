return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { blink = { enabled = true } },
    },
  },
  {
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or `event = 'VeryLazy'`
    opts = {
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map({ 'n', 'i' }, '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', opts)
        map({ 'n', 'i' }, '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', opts)
        map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
        map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
      end,
      --  mappings = { -- false to disable
      --   inline_surround_toggle = "gs", -- (string|boolean) toggle inline style
      --   inline_surround_toggle_line = "gss", -- (string|boolean) line-wise toggle inline style
      --   inline_surround_delete = "ds", -- (string|boolean) delete emphasis surrounding cursor
      --   inline_surround_change = "cs", -- (string|boolean) change emphasis surrounding cursor
      --   link_add = "gl", -- (string|boolean) add link
      --   link_follow = "gx", -- (string|boolean) follow link
      --   go_curr_heading = "]c", -- (string|boolean) set cursor to current section heading
      --   go_parent_heading = "]p", -- (string|boolean) set cursor to parent section heading
      --   go_next_heading = "]]", -- (string|boolean) set cursor to next section heading
      --   go_prev_heading = "[[", -- (string|boolean) set cursor to previous section heading
      -- },
      -- inline_surround = {
      --   emphasis = {
      --     key = "i",
      --     txt = "*",
      --   },
      --   strong = {
      --     key = "b",
      --     txt = "**",
      --   },
      --   strikethrough = {
      --     key = "s",
      --     txt = "~~",
      --   },
      --   code = {
      --     key = "c",
      --     txt = "`",
      --   },
      -- },
    },
  },
}
