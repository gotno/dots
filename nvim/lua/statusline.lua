-- slimline (statusline)
vim.pack.add({
  'https://github.com/sschleemilch/slimline.nvim',
})

require('slimline').setup({
  components = {
    left = {
      'mode',
      -- 'path',
      'git',
    },
    center = {
      -- lsp_status,
    },
    right = {
      'diagnostics',
      'filetype_lsp',
      'progress',
    },
  },
  style = 'fg',
  bold = true,
  hl = {
    secondary = 'Comment',
  },
  configs = {
    mode = {
      hl = {
        normal = 'Type',
        visual = 'Keyword',
        insert = 'Function',
        replace = 'Statement',
        command = 'String',
        other = 'Function',
      },
    },
    path = {
      hl = {
        primary = 'Label',
      },
    },
    git = {
      hl = {
        primary = 'Function',
      },
    },
    filetype_lsp = {
      hl = {
        primary = 'String',
      },
    },
    progress = {
      column = true,
    },
  },
})

-- incline (filename labels)
local function truncate(path, num_chars_in_truncation, num_full_dirs)
  local parts = {}
  for part in path:gmatch('[^/]+') do
    table.insert(parts, part)
  end

  local truncated = {}
  local n_parts = #parts

  for i, component in ipairs(parts) do
    if i > (n_parts - num_full_dirs) then
      table.insert(truncated, component)
    elseif #component > num_chars_in_truncation then
      table.insert(truncated, component:sub(1, num_chars_in_truncation))
    else
      table.insert(truncated, component)
    end
  end

  return table.concat(truncated, '/')
end

vim.pack.add({
  'https://github.com/shaozi/active-gutter.nvim',
  'https://github.com/b0o/incline.nvim',
})
require('incline').setup({
  render = function(props)
    local result = {}

    local path = vim.fs.normalize(vim.fn.expand('#' .. props.buf .. ':.:h'))
    local truncated_path = truncate(path, 3, 3);
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    local is_file = filename ~= ''

    local unsaved = is_file and vim.bo[props.buf].modified

    if unsaved then
      table.insert(result, '* ');
    end

    table.insert(result, {
      is_file and truncated_path .. '/' .. filename or '[no filename]',
      gui = unsaved and 'italic' or '',
    });

    return result;
  end,
  hide = {
    cursorline = 'focused_win', -- hide when cursor is on same line in focused buffer
  },
  window = {
    padding = 1,
    zindex = 9,
    margin = { horizontal = 4 },
    padding_char = " ",
    winhighlight = {
      active = { Normal = 'CurSearch' },
      inactive = { Normal = 'Search' },
    },
  },
})
