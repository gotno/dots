return {
  'b0o/incline.nvim',
  config = function()
    -- path builder stolen entirely from slimline
    ---@param path string
    ---@param chars integer
    ---@param full_dirs integer
    ---@return string
    local function truncate(path, chars, full_dirs)
      local parts = {}
      for part in path:gmatch('[^/]+') do
        table.insert(parts, part)
      end

      local truncated = {}
      local n_parts = #parts

      for i, component in ipairs(parts) do
        if i > (n_parts - full_dirs) then
          table.insert(truncated, component)
        elseif #component > chars then
          table.insert(truncated, component:sub(1, chars))
        else
          table.insert(truncated, component)
        end
      end

      return table.concat(truncated, '/')
    end

    require('incline').setup({
      render = function(props)
        local path = vim.fs.normalize(vim.fn.expand('#' .. props.buf .. ':.:h'))
        local truncated_path = truncate(path, 3, 3);
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        local modified = vim.bo[props.buf].modified
        return {
          ' ',
          truncated_path .. '/' .. filename,
          modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
          ' ',
          guibg = '#111111',
          guifg = '#eeeeee',
        }
      end,
      hide = {
        cursorline = 'focused_win', -- hide when cursor is on same line in focused buffer
      },
    })
  end,
  event = 'VeryLazy',
}
