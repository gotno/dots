vim.pack.add({
  'https://github.com/Cannon07/code-preview.nvim',
})
require('code-preview').setup({
  diff = {
    layout = 'tab', -- tab (split diff) | vsplit | inline (tab but unified diff)
    labels = { current = 'NOW', proposed = 'PROPOSED' },
  }
})
-- run :CodePreviewInstallCopilotCliHooks
--     :CodePreviewInstallClaudeCodeHooks

vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sidekick_terminal',
  callback = function(args)
    local light = vim.o.background == 'light'
    vim.b[args.buf].sidekick_palette_light = light
    if light then
      vim.b[args.buf].terminal_color_7 = '#333333'
    end
  end,
})

local palette_update = 0
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    palette_update = palette_update + 1
    local update = palette_update
    vim.defer_fn(function()
      if update ~= palette_update then return end
      local light = vim.o.background == 'light'
      local terminals = require('sidekick.cli.terminal').sessions()
      local session = require('sidekick.cli.session')

      for _, terminal in ipairs(terminals) do
        if terminal:buf_valid() and vim.b[terminal.buf].sidekick_palette_light ~= light then
          if terminal.mux_backend ~= 'tmux' or not terminal.parent then
            vim.notify('Cannot refresh a Sidekick terminal without a tmux session', vim.log.levels.WARN)
          else
            local current_win = vim.api.nvim_get_current_win()
            local visible = terminal:is_open()
            local focused = visible and current_win == terminal.win
            local normal_mode = terminal.normal_mode
            local width = visible and vim.api.nvim_win_get_width(terminal.win)
            local tab = visible and vim.api.nvim_win_get_tabpage(terminal.win)
            local parent = terminal.parent

            if tab then vim.api.nvim_set_current_tabpage(tab) end
            terminal:close()
            parent.started = true
            local refreshed = session.attach(parent)
            if not refreshed:is_running() then
              vim.notify('Failed to reconnect the Sidekick tmux session', vim.log.levels.ERROR)
            elseif not visible then
              refreshed:hide()
            else
              vim.api.nvim_win_set_width(refreshed.win, width)
              if focused then
                vim.api.nvim_set_current_win(refreshed.win)
                refreshed.normal_mode = normal_mode
                if not normal_mode then vim.cmd.startinsert() end
              end
            end
            if not focused and vim.api.nvim_win_is_valid(current_win) then
              vim.api.nvim_set_current_win(current_win)
            end
          end
        end
      end
    end, 250)
  end,
})

require('sidekick').setup({
    nes = {
    ---@type boolean|fun(buf:integer):boolean?
    enabled = function(buf)
      return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
    end,
    debounce = 100,
    trigger = {
      -- events that trigger sidekick next edit suggestions
      events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone" },
    },
    clear = {
      -- events that clear the current next edit suggestion
      events = { "TextChangedI", "InsertEnter" },
      esc = true, -- clear next edit suggestions when pressing <Esc>
    },
    ---@class sidekick.diff.Opts
    ---@field inline? "words"|"chars"|false Enable inline diffs
    ---@field show? "always"|"cursor" `cursor` will only show the diff when the cursor is at the edit position.
    diff = {
      inline = false,
      show = "always",
    },
    signs = true, -- show signs for next edit suggestions
    jumplist = true, -- add an entry to the jumplist
  },
  cli = {
    mux = {
      enabled = true,
      backend = 'tmux',
    },
    win = {
      layout = 'right',
      split = {
        width = 80,
      },
    },
    tools = {
      copilot = {
        cmd = {
          'copilot',
          '--banner',
          '--allow-tool=shell(date:*)',
          '--allow-tool=shell(echo:*)',
          '--allow-tool=shell(cat:*)',
          '--allow-tool=shell(ls:*)',
          '--allow-tool=shell(mkdir:*)',
          '--allow-tool=shell(wc:*)',
          '--allow-tool=shell(head:*)',
          '--allow-tool=shell(tail:*)',
          '--allow-tool=shell(sort:*)',
          '--allow-tool=shell(grep:*)',
          '--allow-tool=shell(tr:*)',
          '--allow-tool=shell(printf:*)',
          '--allow-tool=shell(find:*)',
          '--allow-tool=shell(git add:*)',
          '--allow-tool=shell(git commit:*)',
          '--allow-tool=shell(git status:*)',
          '--allow-tool=shell(git log:*)',
          '--allow-tool=shell(git diff:*)',
          '--allow-tool=shell(git tag:*)',
        },
      },
    },
  },
})

vim.keymap.set(
  {'n', 'x'},
  ',c',
  function()
    require("sidekick.cli").toggle({ name = "claude", focus = true })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'n', 'x'},
  ',.',
  function()
    require("sidekick.cli").toggle({ name = "copilot", focus = true })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'n', 'x'},
  ',t',
  function()
    require("sidekick.cli").send({ msg = "{this}" })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'x'},
  ',v',
  function()
    require("sidekick.cli").send({ msg = "{selection}" })
  end,
  { noremap = true, silent = true }
)
vim.keymap.set(
  {'n'},
  ',f',
  function()
    require("sidekick.cli").send({ msg = "{file}" })
  end,
  { noremap = true, silent = true }
)

vim.keymap.set(
  {'i'},
  '<tab>',
  function()
    -- jump to or apply next edit
    if require('sidekick').nes_jump_or_apply() then
      return
    end

    -- trigger inline completion if present
    if vim.lsp.inline_completion.get() then
      return
    end

    -- otherwise, fall back to default <tab>
    return '<tab>'
  end,
  { noremap = true, silent = true }
)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local client_has_inline_completion =
      client:supports_method(
        vim.lsp.protocol.Methods.textDocument_inlineCompletion,
        bufnr
      )

    if client_has_inline_completion then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
    end
  end
})

-- ---@class sidekick.Config
-- local defaults = {
--   jump = {
--     jumplist = true, -- add an entry to the jumplist
--   },
--   signs = {
--     enabled = true, -- enable signs by default
--     icon = " ",
--   },
--   nes = {
--     ---@type boolean|fun(buf:integer):boolean?
--     enabled = function(buf)
--       return vim.g.sidekick_nes ~= false and vim.b.sidekick_nes ~= false
--     end,
--     debounce = 100,
--     trigger = {
--       -- events that trigger sidekick next edit suggestions
--       events = { "ModeChanged i:n", "TextChanged", "User SidekickNesDone" },
--     },
--     clear = {
--       -- events that clear the current next edit suggestion
--       events = { "TextChangedI", "InsertEnter" },
--       esc = true, -- clear next edit suggestions when pressing <Esc>
--     },
--     ---@class sidekick.diff.Opts
--     ---@field inline? "words"|"chars"|false Enable inline diffs
--     diff = {
--       inline = "words",
--     },
--   },
--   -- Work with AI cli tools directly from within Neovim
--   cli = {
--     watch = true, -- notify Neovim of file changes done by AI CLI tools
--     ---@class sidekick.win.Opts
--     win = {
--       --- This is run when a new terminal is created, before starting it.
--       --- Here you can change window options `terminal.opts`.
--       ---@param terminal sidekick.cli.Terminal
--       config = function(terminal) end,
--       wo = {}, ---@type vim.wo
--       bo = {}, ---@type vim.bo
--       layout = "right", ---@type "float"|"left"|"bottom"|"top"|"right"
--       --- Options used when layout is "float"
--       ---@type vim.api.keyset.win_config
--       float = {
--         width = 0.9,
--         height = 0.9,
--       },
--       -- Options used when layout is "left"|"bottom"|"top"|"right"
--       ---@type vim.api.keyset.win_config
--       split = {
--         width = 80, -- set to 0 for default split width
--         height = 20, -- set to 0 for default split height
--       },
--       --- CLI Tool Keymaps (default mode is `t`)
--       ---@type table<string, sidekick.cli.Keymap|false>
--       keys = {
--         buffers       = { "<c-b>", "buffers"   , mode = "nt", desc = "open buffer picker" },
--         files         = { "<c-f>", "files"     , mode = "nt", desc = "open file picker" },
--         hide_n        = { "q"    , "hide"      , mode = "n" , desc = "hide the terminal window" },
--         hide_ctrl_q   = { "<c-q>", "hide"      , mode = "n" , desc = "hide the terminal window" },
--         hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "hide the terminal window" },
--         hide_ctrl_z   = { "<c-z>", "hide"      , mode = "nt", desc = "hide the terminal window" },
--         prompt        = { "<c-p>", "prompt"    , mode = "t" , desc = "insert prompt or context" },
--         stopinsert    = { "<c-q>", "stopinsert", mode = "t" , desc = "enter normal mode" },
--         -- Navigate windows in terminal mode. Only active when:
--         -- * layout is not "float"
--         -- * there is another window in the direction
--         -- With the default layout of "right", only `<c-h>` will be mapped
--         nav_left      = { "<c-h>", "nav_left"  , expr = true, desc = "navigate to the left window" },
--         nav_down      = { "<c-j>", "nav_down"  , expr = true, desc = "navigate to the below window" },
--         nav_up        = { "<c-k>", "nav_up"    , expr = true, desc = "navigate to the above window" },
--         nav_right     = { "<c-l>", "nav_right" , expr = true, desc = "navigate to the right window" },
--       },
--       ---@type fun(dir:"h"|"j"|"k"|"l")?
--       --- Function that handles navigation between windows.
--       --- Defaults to `vim.cmd.wincmd`. Used by the `nav_*` keymaps.
--       nav = nil,
--     },
--     ---@class sidekick.cli.Mux
--     ---@field backend? "tmux"|"zellij" Multiplexer backend to persist CLI sessions
--     mux = {
--       backend = vim.env.ZELLIJ and "zellij" or "tmux", -- default to tmux unless zellij is detected
--       enabled = false,
--       -- terminal: new sessions will be created for each CLI tool and shown in a Neovim terminal
--       -- window: when run inside a terminal multiplexer, new sessions will be created in a new tab
--       -- split: when run inside a terminal multiplexer, new sessions will be created in a new split
--       -- NOTE: zellij only supports `terminal`
--       create = "terminal", ---@type "terminal"|"window"|"split"
--       split = {
--         vertical = true, -- vertical or horizontal split
--         size = 0.5, -- size of the split (0-1 for percentage)
--       },
--     },
--     ---@type table<string, sidekick.cli.Config|{}>
--     tools = {
--       aider = { cmd = { "aider" } },
--       amazon_q = { cmd = { "q" } },
--       claude = { cmd = { "claude" } },
--       codex = { cmd = { "codex", "--enable", "web_search_request" } },
--       copilot = { cmd = { "copilot", "--banner" } },
--       crush = {
--         cmd = { "crush" },
--         -- crush uses <a-p> for its own functionality, so we override the default
--         keys = { prompt = { "<a-p>", "prompt" } },
--       },
--       cursor = { cmd = { "cursor-agent" } },
--       gemini = { cmd = { "gemini" } },
--       grok = { cmd = { "grok" } },
--       opencode = {
--         cmd = { "opencode" },
--         -- HACK: https://github.com/sst/opencode/issues/445
--         env = { OPENCODE_THEME = "system" },
--       },
--       qwen = { cmd = { "qwen" } },
--     },
--     --- Add custom context. See `lua/sidekick/context/init.lua`
--     ---@type table<string, sidekick.context.Fn>
--     context = {},
--     ---@type table<string, sidekick.Prompt|string|fun(ctx:sidekick.context.ctx):(string?)>
--     prompts = {
--       changes         = "Can you review my changes?",
--       diagnostics     = "Can you help me fix the diagnostics in {file}?\n{diagnostics}",
--       diagnostics_all = "Can you help me fix these diagnostics?\n{diagnostics_all}",
--       document        = "Add documentation to {function|line}",
--       explain         = "Explain {this}",
--       fix             = "Can you fix {this}?",
--       optimize        = "How can {this} be optimized?",
--       review          = "Can you review {file} for any issues or improvements?",
--       tests           = "Can you write tests for {this}?",
--       -- simple context prompts
--       buffers         = "{buffers}",
--       file            = "{file}",
--       line            = "{line}",
--       position        = "{position}",
--       quickfix        = "{quickfix}",
--       selection       = "{selection}",
--       ["function"]    = "{function}",
--       class           = "{class}",
--     },
--     -- preferred picker for selecting files
--     ---@alias sidekick.picker "snacks"|"telescope"|"fzf-lua"
--     picker = "snacks", ---@type sidekick.picker
--   },
--   copilot = {
--     -- track copilot's status with `didChangeStatus`
--     status = {
--       enabled = true,
--       level = vim.log.levels.WARN,
--       -- set to vim.log.levels.OFF to disable notifications
--       -- level = vim.log.levels.OFF,
--     },
--   },
--   ui = {
--     icons = {
--       attached          = " ",
--       started           = " ",
--       installed         = " ",
--       missing           = " ",
--       external_attached = "󰖩 ",
--       external_started  = "󰖪 ",
--       terminal_attached = " ",
--       terminal_started  = " ",
--     },
--   },
--   debug = false, -- enable debug logging
-- }

 -- tab for nes with fallback
 --    {
 --      "<tab>",
 --      function()
 --        -- if there is a next edit, jump to it, otherwise apply it if any
 --        if require("sidekick").nes_jump_or_apply() then
 --          return -- jumped or applied
 --        end
 --
 --        -- if you are using Neovim's native inline completions
 --        if vim.lsp.inline_completion.get() then
 --          return
 --        end
 --
 --        -- any other things (like snippets) you want to do on <tab> go here.
 --
 --        -- fall back to normal tab
 --        return "<tab>"
 --      end,
 --      mode = { "i", "n" },
 --      expr = true,
 --      desc = "Goto/Apply Next Edit Suggestion",
 --    },

-- example keymaps
-- {
--   "folke/sidekick.nvim",
--   opts = {
--     -- add any options here
--     cli = {
--       mux = {
--         backend = "zellij",
--         enabled = true,
--       },
--     },
--   },
--   keys = {
--     {
--       "<tab>",
--       function()
--         -- if there is a next edit, jump to it, otherwise apply it if any
--         if not require("sidekick").nes_jump_or_apply() then
--           return "<Tab>" -- fallback to normal tab
--         end
--       end,
--       expr = true,
--       desc = "Goto/Apply Next Edit Suggestion",
--     },
--     {
--       "<c-.>",
--       function() require("sidekick.cli").toggle() end,
--       desc = "Sidekick Toggle",
--       mode = { "n", "t", "i", "x" },
--     },
--     {
--       "<leader>aa",
--       function() require("sidekick.cli").toggle() end,
--       desc = "Sidekick Toggle CLI",
--     },
--     {
--       "<leader>as",
--       function() require("sidekick.cli").select() end,
--       -- Or to select only installed tools:
--       -- require("sidekick.cli").select({ filter = { installed = true } })
--       desc = "Select CLI",
--     },
--     {
--       "<leader>ad",
--       function() require("sidekick.cli").close() end,
--       desc = "Detach a CLI Session",
--     },
--     {
--       "<leader>at",
--       function() require("sidekick.cli").send({ msg = "{this}" }) end,
--       mode = { "x", "n" },
--       desc = "Send This",
--     },
--     {
--       "<leader>af",
--       function() require("sidekick.cli").send({ msg = "{file}" }) end,
--       desc = "Send File",
--     },
--     {
--       "<leader>av",
--       function() require("sidekick.cli").send({ msg = "{selection}" }) end,
--       mode = { "x" },
--       desc = "Send Visual Selection",
--     },
--     {
--       "<leader>ap",
--       function() require("sidekick.cli").prompt() end,
--       mode = { "n", "x" },
--       desc = "Sidekick Select Prompt",
--     },
--     -- Example of a keybinding to open Claude directly
--     {
--       "<leader>ac",
--       function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
--       desc = "Sidekick Toggle Claude",
--     },
--   },
-- }
