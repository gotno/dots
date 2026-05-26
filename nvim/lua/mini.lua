vim.pack.add({
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.pick',
})

require('mini.pick').setup({
  window = {
    -- config = {
    --   anchor = 'NW',
    --   relative = 'cursor',
    --   width = 40,
    --   height = 20,
    --   row = 0,
    --   col = 0,
    -- },
    prompt_caret = '|',
    prompt_prefix = ' > ',
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        border = 'rounded',
        anchor = 'NW', height = height, width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})
local MiniPick = require('mini.pick')

vim.keymap.set(
  {'n', 'x'},
  '<leader><leader>',
  function()
    if not pcall(MiniPick.builtin.resume) then
      MiniPick.builtin.files()
    end
  end,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'n', 'x'},
  '<leader>f', MiniPick.builtin.files,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'n', 'x'},
  '<leader>/', MiniPick.builtin.grep_live,
  { noremap = true, silent = true }
)

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
local MiniFiles = require('mini.files')

vim.keymap.set(
  { 'n', 'x' },
  '<leader>e',
  function ()
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
  MiniFiles.refresh({
    content = {
      filter = show_dotfiles and filter_show_dots or filter_hide_dots,
    },
  })
end

local show_preview = false
local preview_width = function ()
  local max_preview_width = 80
  local explorer_state = MiniFiles.get_explorer_state()
  if explorer_state == nil then return max_preview_width end

  local preview_path =
    show_preview and explorer_state.branch[explorer_state.depth_focus + 1] or nil
  local used_columns = 0

  for _, window in ipairs(explorer_state.windows) do
    if window.path ~= preview_path then
      used_columns = used_columns + vim.api.nvim_win_get_width(window.win_id) + 2
    end
  end

  local remaining_columns = vim.o.columns - used_columns - 2
  return math.max(1, math.min(max_preview_width, remaining_columns))
end
local toggle_preview = function()
  show_preview = not show_preview
  MiniFiles.refresh({
    windows = {
      preview = show_preview,
      width_preview = preview_width(),
    },
  })
  MiniFiles.trim_right()
end

local grep_in_dir = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return nil end
  MiniFiles.close()
  MiniPick.builtin.grep_live(nil, {
    source = {
      name = 'grep in ' .. vim.fn.fnamemodify(path, ':.:h'),
      cwd = vim.fs.dirname(path)
    },
  });
end
local find_in_dir = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return nil end
  MiniFiles.close()
  MiniPick.builtin.files(nil, {
    source = {
      name = 'files in ' .. vim.fn.fnamemodify(path, ':.:h'),
      cwd = vim.fs.dirname(path)
    },
  });
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  group = vim.api.nvim_create_augroup('gtno-minifiles-spawn', { clear = true }),
  callback = function(args)
    local buf_id = args.data.buf_id
    -- TODO picker
    vim.keymap.set('n', '<leader>f', find_in_dir, { buffer = buf_id })
    vim.keymap.set('n', '<leader>/', grep_in_dir, { buffer = buf_id })
    vim.keymap.set({ 'n', 'x' }, 'zh', toggle_dotfiles, { buffer = buf_id })
    vim.keymap.set({ 'n', 'x' }, '<tab>', toggle_preview, { buffer = buf_id })
    vim.keymap.set(
      { 'n', 'x' },
      '<esc>', MiniFiles.close,
      { buffer = buf_id }
    )

    -- restore previous state
    vim.defer_fn(function()
      MiniFiles.refresh({
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

local function is_normal_file_buffer(bufnum)
  return vim.api.nvim_buf_is_valid(bufnum)
    and vim.fn.buflisted(bufnum) == 1
    and vim.bo[bufnum].buftype == ""
    and vim.api.nvim_buf_get_name(bufnum) ~= ""
end
vim.keymap.set(
  -- delete other buffers
  {'n', 'x'},
  '<leader>Q',
  function()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, bufnum in ipairs(vim.api.nvim_list_bufs()) do
      if bufnum ~= current_buf and is_normal_file_buffer(bufnum) then
        require('mini.bufremove').delete(bufnum)
      end
    end
  end
)
