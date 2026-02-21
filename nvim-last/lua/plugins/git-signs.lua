return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
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
        --    
        -- hl groups
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

        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = ' <author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gitsigns = require 'gitsigns'

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

          -- navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gitsigns.nav_hunk 'next'
            end
          end, { desc = 'Jump to next git [c]hange' })
          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gitsigns.nav_hunk 'prev'
            end
          end, { desc = 'Jump to previous git [c]hange' })

          -- actions
          -- stage hunk
          map(
            'v', '<leader>gsh',
            function()
              gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end,
            { desc = 'git [s]tage hunk' }
          )
          map('n', '<leader>gsh', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
          -- reset hunk
          map(
            'v', '<leader>grh',
            function()
              gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end,
            { desc = 'git [r]eset hunk' }
          )
          map('n', '<leader>grh', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
          -- preview hunk
          map('n', '<leader>gdh', gitsigns.preview_hunk_inline, { desc = 'git [p]review hunk inline' })
          -- map('n', '<leader>gdH', gitsigns.preview_hunk, { desc = 'git [P]review hunk' })

          -- stage/reset/diff buffer
          map('n', '<leader>gsb', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
          map('n', '<leader>grb', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
          map('n', '<leader>gdb', gitsigns.diffthis, { desc = 'git [d]iff against index' })
          map(
            'n', '<leader>gdB',
            function()
              gitsigns.diffthis '@'
            end,
            { desc = 'git [D]iff against last commit' }
          )

          -- blame
          map('n', '<leader>gbl', gitsigns.blame_line, { desc = 'git [b]lame line' })
          map('n', '<leader>gbt', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        end
      }
    end,
  }
}
