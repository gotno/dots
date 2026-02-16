-- MiniCompletion + MiniSnippets
vim.pack.add({
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/nvim-mini/mini.snippets',
  'https://github.com/nvim-mini/mini.completion',
})
require('mini.icons').setup()
require('mini.icons').tweak_lsp_kind('prepend')
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    -- gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})
require('mini.completion').setup()

-- MiniFiles
vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })
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
vim.keymap.set(
  { 'n', 'x' },
  '<leader>e',
  function ()
    local MiniFiles = require("mini.files")
    local _ = MiniFiles.close()
      or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    vim.defer_fn(function()
      MiniFiles.reveal_cwd()
    end, 10)
  end
)

local show_dotfiles = false
local filter_show_dots = function(_)
  return true
end
local filter_hide_dots = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end
local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  require('mini.files').refresh({
    content = {
      filter = show_dotfiles and filter_show_dots or filter_hide_dots,
    },
  })
end

local show_preview = false
local preview_width = function ()
  -- TODO: 80 OR remaining available columns
  return 80
end
local toggle_preview = function()
  show_preview = not show_preview
  require('mini.files').refresh({
    windows = {
      preview = show_preview,
      width_preview = preview_width(),
    },
  })
  require('mini.files').trim_right()
end

-- TODO: switch to mini.pick
-- local grep_in_dir = function()
--   local path = (MiniFiles.get_fs_entry() or {}).path
--   if path == nil then return nil end
--   require('mini.files').close()
--   require('snacks.picker').grep({ dirs = { vim.fs.dirname(path)} })
-- end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  group = vim.api.nvim_create_augroup('gtno-minifiles-spawn', { clear = true }),
  callback = function(args)
    local buf_id = args.data.buf_id
    -- TODO picker
    -- vim.keymap.set('n', 'g/', grep_in_dir, { buffer = buf_id, desc = 'grep in dir' })
    vim.keymap.set({ 'n', 'x' }, 'zh', toggle_dotfiles, { buffer = buf_id })
    vim.keymap.set({ 'n', 'x' }, '<tab>', toggle_preview, { buffer = buf_id })
    vim.keymap.set(
      { 'n', 'x' },
      '<esc>', require("mini.files").close,
      { buffer = buf_id }
    )

    -- restore previous state
    vim.defer_fn(function()
      require('mini.files').refresh({
        content = {
          filter = show_dotfiles and filter_show_dots or filter_hide_dots
        },
        windows = {
          preview = show_preview,
          width_preview = preview_width(),
        },
      })
    end, 10)
  end,
})

vim.pack.add({ 'https://github.com/nvim-mini/mini.notify' })
require('mini.notify').setup()

-- MiniBufremove
vim.pack.add({ 'https://github.com/nvim-mini/mini.bufremove' })
require('mini.bufremove').setup()
vim.keymap.set(
  -- delete buffer
  {'n', 'x'},
  '<leader>q',
  function()
    require('mini.bufremove').delete(vim.api.nvim_get_current_buf())
  end
)
vim.keymap.set(
  -- delete other buffers
  {'n', 'x'},
  '<leader>Q',
  function()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, bufnum in ipairs(vim.api.nvim_list_bufs()) do
      if bufnum ~= current_buf then
        require('mini.bufremove').delete(bufnum)
      end
    end
  end
)
