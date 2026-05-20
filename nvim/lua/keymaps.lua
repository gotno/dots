local map = function(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- unset/override
map('n', ')', '<nop>')
map('n', '(', '<nop>')
map('n', 'q:', '<nop>')
map('n', 'q/', '<nop>')
map('n', 'q?', '<nop>')

-- for mis-timed shift+; on the planck 🙄
map('n', '(;', ':')

-- linewise nav works the same for wrapped lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- beginning/end of line on H/L
map('n', 'H', '^')
map('n', 'dH', 'd^')
map('n', 'cH', 'c^')
map('n', 'yH', 'y^')
map('n', 'L', '$')
-- (for completeness, but same as D/C/Y)
map('n', 'dL', 'd$')
map('n', 'cL', 'c$')
map('n', 'yL', 'y$')

-- clear search highlights
map('n', '<esc>', '<cmd>nohlsearch<cr>', { noremap = false })

-- splits
map('n', '<leader>i', '<cmd>vsp<cr>')
map('n', '<leader>o', '<cmd>sp<cr>')

-- toggle maximize (split to new tab/close if only window in tab)
map(
  'n',
  '<leader><enter>',
  function ()
    local bufnums = vim.fn.tabpagebuflist()
    local num_relevant_bufs = 0
    for _, v in ipairs(bufnums) do
      if vim.bo[v].buftype == '' or vim.bo[v].buftype == 'help' then
        num_relevant_bufs = num_relevant_bufs + 1
      end
      if num_relevant_bufs > 1 then
        vim.cmd('tab split')
        return
      end
    end

    vim.cmd.quit()
  end
)
map('n', '<leader>T', '<cmd>$tabnew<cr>')

-- toggle 'narrow selection' (fold all but visual line selection, unfold all)
map('v', 'zn', '<esc>`<kzfgg`>jzfG`<')

-- close window(s)
map('n', '<leader>w', '<cmd>q<cr>')
map('n', '<leader>W', '<cmd>qa<cr>')
-- close buffer(s)
-- (see mini config)

-- resize splits
map({'n', 'x'}, '=', '<cmd>vertical resize +5<cr>')
map({'n', 'x'}, '-', '<cmd>vertical resize -5<cr>')
map({'n', 'x'}, '+', '<cmd>horizontal resize +2<cr>')
map({'n', 'x'}, '_', '<cmd>horizontal resize -2<cr>')
-- equalize splits
map({'n', 'x'}, '<leader>=', '<c-w>=')

-- yank file path/name
local function buf_abs()
  return vim.api.nvim_buf_get_name(0)
end
vim.keymap.set(
  'n', '<leader>yr',
  function()
    local rel = vim.fn.fnamemodify(buf_abs(), ':.')
    vim.fn.setreg('+', rel)
    vim.notify('yanked ' .. rel)
  end,
  { desc = 'yank relative path' }
)
vim.keymap.set(
  'n', '<leader>ya',
  function()
    local abs = vim.fn.fnamemodify(buf_abs(), ':p')
    vim.fn.setreg('+', abs)
    vim.notify('yanked ' .. abs)
  end,
  { desc = 'yank absolute path' }
)
vim.keymap.set(
  'n', '<leader>yd',
  function()
    local dir = vim.fn.fnamemodify(buf_abs(), ':p:h')
    vim.fn.setreg('+', dir)
    vim.notify('yanked ' .. dir)
  end,
  { desc = 'yank directory' }
)
vim.keymap.set(
  'n', '<leader>yf',
  function()
    local name = vim.fn.fnamemodify(buf_abs(), ':t')
    vim.fn.setreg('+', name)
    vim.notify('yanked ' .. name)
  end,
  { desc = 'yank filename' }
)

local function git_yank_url(line1, line2, use_master)
  local abs = buf_abs()
  if abs == '' then
    vim.notify('no file', vim.log.levels.WARN)
    return
  end

  local file_dir = vim.fn.fnamemodify(abs, ':p:h')
  local function git(cmd)
    return vim.fn.system(
      'git -C ' .. vim.fn.shellescape(file_dir) .. ' ' .. cmd .. ' 2>/dev/null'
    ):gsub('\n', '')
  end

  local remote = git('remote get-url origin')
  if remote == '' then
    vim.notify('no git remote', vim.log.levels.WARN)
    return
  end

  local rel = git('ls-files --full-name ' .. vim.fn.shellescape(abs))
  if rel == '' then
    vim.notify('file not tracked by git', vim.log.levels.WARN)
    return
  end

  local branch
  if use_master then
    local default =
      git('symbolic-ref refs/remotes/origin/HEAD'):match('refs/remotes/origin/(.+)')
    if not default then
      vim.notify('could not determine default branch', vim.log.levels.WARN)
      return
    end
    git('cat-file -e refs/remotes/origin/HEAD:' .. vim.fn.shellescape(rel))
    if vim.v.shell_error == 0 then
      branch = default
    else
      vim.notify('file not in ' .. default .. ' branch', vim.log.levels.WARN)
      return
    end
  else
    branch = git('branch --show-current')
    if branch == '' then
      vim.notify('could not determine branch', vim.log.levels.WARN)
      return
    end
  end

  local host, path = remote:match('^git@([^:]+):(.+)$')
  local url = host and ('https://' .. host .. '/' .. path) or remote
  url = url:gsub('%.git$', '')

  local line_ref =
    (line2 and line2 ~= line1)
      and ('#L' .. line1 .. '-L' .. line2)
      or ('#L' .. line1)
  local full_url = url .. '/blob/' .. branch .. '/' .. rel .. line_ref
  vim.fn.setreg('+', full_url)
  vim.notify('yanked ' .. full_url)
end

vim.keymap.set(
  'n', '<leader>yg',
  function() git_yank_url(vim.fn.line('.')) end,
  { desc = 'yank github url (current branch)' }
)
vim.keymap.set(
  'v', '<leader>yg',
  function() git_yank_url(vim.fn.line("'<"), vim.fn.line("'>")) end,
  { desc = 'yank github url (current branch)' }
)
vim.keymap.set(
  'n', '<leader>yG',
  function() git_yank_url(vim.fn.line('.'), nil, true) end,
  { desc = 'yank github url (main branch)' }
)
vim.keymap.set(
  'v', '<leader>yG',
  function() git_yank_url(vim.fn.line("'<"), vim.fn.line("'>"), true) end,
  { desc = 'yank github url (main branch)' }
)

-- `gS` to split/join argument lists
vim.pack.add({
  'https://github.com/nvim-mini/mini.splitjoin',
})
require('mini.splitjoin').setup()
