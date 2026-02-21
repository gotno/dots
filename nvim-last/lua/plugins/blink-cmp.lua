return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
  },
  build = 'cargo build --release',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      -- defaults:
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      -- ['<C-e>'] = { 'hide', 'fallback' },
      -- ['<C-y>'] = { 'select_and_accept', 'fallback' },
      --
      -- ['<Up>'] = { 'select_prev', 'fallback' },
      -- ['<Down>'] = { 'select_next', 'fallback' },
      -- ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
      -- ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
      --
      -- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      -- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      --
      -- ['<Tab>'] = { 'snippet_forward', 'fallback' },
      -- ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      --
      -- ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = { nerd_font_variant = 'mono' },
    completion = {
      -- ghost_text = {
      --   enabled = true,
      --   show_with_menu = false,
      -- },
      documentation = {
        auto_show = false
      },
      menu = {
        auto_show = true, -- set to false to prefer ghost_text settings above
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 }
          },
        }
      },
    },
    { signature = { enabled = true } },

    sources = {
      default = { 'lsp', 'path', 'copilot' },

      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' }
      },

      providers = {
        lsp = {
          enabled = true,
          module = 'blink.cmp.sources.lsp',
          score_offset = 999,
        },
        lazydev = {
          enabled = true,
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        copilot = {
          name = 'copilot',
          module = 'blink-copilot',
          score_offset = 50,
          async = true,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
