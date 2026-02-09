return {
  'Bekaboo/deadcolumn.nvim',
  config = function()
    require('deadcolumn').setup({
			scope = function()
        -- disabled for these filetypes
				if vim.tbl_contains({ 'markdown' }, vim.bo.filetype) then
          return 0
				end

				-- disabled for readonly buffers
				if not vim.bo.ma or vim.bo.ro then
					return 0
				end

				-- show if a visible line is too long
				local max_len = math.max(
					unpack(
						vim.tbl_map(
							vim.fn.strdisplaywidth,
							vim.api.nvim_buf_get_lines(
								0,
								vim.fn.line('w0') - 1,
								vim.fn.line('w$'),
								false
							)
						)
					)
				)

				if max_len >= cc_resolve(vim.wo.cc) then
					return max_len
				end
				return 0
			end,
      modes = function()
        return true
      end,
    })
  end,
}
