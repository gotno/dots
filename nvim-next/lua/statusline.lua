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
