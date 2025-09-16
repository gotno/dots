return {
  'echasnovski/mini.nvim',
  dependencies = { 'folke/snacks.nvim' },
  lazy = false,
  config = function()
    require('mini.icons').setup()
    require('mini.files').setup({
      mappings = {
        close = 'q',
        synchronize = 'w', -- "write"
        go_in_plus = 'E',
      },
      windows = {
        preview = false,
      },
      options = {
        use_as_default_explorer = true,
      },
    })

    local show_dotfiles = false

    local filter_show = function(fs_entry)
      return true
    end

    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, ".")
    end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require('mini.files').refresh { content = { filter = new_filter } }
    end

    local grep_in_dir = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return nil end
      require('mini.files').close()
      require('snacks.picker').grep({ dirs = { path } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set('n', 'g/', grep_in_dir, { buffer = buf_id, desc = 'grep in dir' })
        vim.keymap.set('n', 'zh', toggle_dotfiles, { buffer = buf_id })
        vim.keymap.set('n', '<Esc>', require("mini.files").close, { buffer = buf_id })
        vim.defer_fn(function()
          if show_dotfiles then
            require('mini.files').refresh { content = { filter = filter_show } }
          else
            require('mini.files').refresh { content = { filter = filter_hide } }
          end
        end, 30)
      end,
    })
  end,
  keys = {
    {
      '<leader>e',
      function ()
        local MiniFiles = require("mini.files")
        local _ = MiniFiles.close()
          or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
        vim.defer_fn(function()
          MiniFiles.reveal_cwd()
        end, 30)
      end,
      desc = "toggle mini.files",
    }
  },
}
