vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
})
require('gitsigns').setup({
  signs = {
    add          = { text = '' },
    change       = { text = '' },
    delete       = { text = '_', show_count = true },
    topdelete    = { text = '‾', show_count = true },
    changedelete = { text = '~', show_count = true },
    untracked    = { text = '┆' },
  },

  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  on_attach = function(bufnr)
    local gitsigns = require "gitsigns"

    local function map(mode, key, fn, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(
        mode,
        key,
        function()
          fn()
          vim.defer_fn(
            function()
              gitsigns.reset_base()
            end,
            100
          )
        end,
        opts
      )
    end

    -- jump to next/prev hunk
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end)
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end)

    -- stage/unstage hunk visual/normal
    map('v', '<leader>gsh', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)
    map('n', '<leader>gsh', gitsigns.stage_hunk)

    -- reset hunk visual/normal
    map('v', '<leader>grh', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)
    map('n', '<leader>grh', gitsigns.reset_hunk)

    -- diff hunk
    map('n', '<leader>gdh', gitsigns.preview_hunk_inline)
    map('n', '<leader>gdH', gitsigns.preview_hunk)

    -- blame
    map('n', '<leader>gbl', gitsigns.blame_line)
    map('n', '<leader>gbt', gitsigns.toggle_current_line_blame)
    map('n', '<leader>gbb', gitsigns.blame)
  end
})
