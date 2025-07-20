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
      -- these don't work?
      -- ['<C-b>'] = {
      --   'scroll_documentation_up',
      --   -- function(cmp)
      --   --   cmp.scroll_documentation_up(2)
      --   -- end,
      --   'fallback',
      -- },
      -- ['<C-f>'] = {
      --   'scroll_documentation_down',
      --   -- function(cmp)
      --   --   cmp.scroll_documentation_down(2)
      --   -- end,
      --   'fallback',
      -- },
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
        auto_show = false, -- set to prefer ghost_text
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 }
          },
        }
      },
    },

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
