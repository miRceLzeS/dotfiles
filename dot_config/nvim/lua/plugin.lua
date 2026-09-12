local keymap = require("keymap")
local autocmd = require("autocmd").autocmd

-- ==========
-- Helper
-- ==========

local packadd = function(specs, opts)
  opts = vim.tbl_extend("force", { confirm = false }, opts or {})
  vim.pack.add(specs, opts)
end

local group = vim.api.nvim_create_augroup("LazyPack", {})

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "VeryLazy",
        modeline = false,
      })
    end)
  end,
})

local lazy = function(fn)
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    once = true,
    callback = function() fn() end,
  })
end

-- ==========
-- Appearence
-- ==========

-- color scheme
packadd({ "https://github.com/rose-pine/neovim" })
require("rose-pine").setup({ styles = { transparency = true } })
vim.cmd.colorscheme("rose-pine")

-- icon
packadd({ "https://github.com/nvim-tree/nvim-web-devicons" })
require("nvim-web-devicons").setup()

lazy(function()
  packadd({ "https://github.com/lewis6991/gitsigns.nvim" })

  require("gitsigns").setup({
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "-" },
      topdelete    = { text = "-" },
      changedelete = { text = "~" },
      untracked    = { text = "?" },
    },
    signs_staged = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "-" },
      topdelete    = { text = "-" },
      changedelete = { text = "~" },
      untracked    = { text = "?" },
    },
    current_line_blame = true,
    current_line_blame_opts = { delay = 250 },
  })
end)

lazy(function()
  packadd({ "https://github.com/nvim-lualine/lualine.nvim" })

  local theme = require("lualine.themes.rose-pine")
  local p = require("rose-pine.palette")
  local config = require("rose-pine.config")

  local bg_base = p.surface
  if config.options.styles.transparency then
    bg_base = "NONE"
    vim.api.nvim_set_hl(0, "StatusLineTerm", { fg = "NONE", bg = "NONE" })
  end

  theme.terminal = {
    a = { bg = p.rose, fg = p.base, gui = "bold" },
    b = { bg = p.overlay, fg = p.rose },
    c = { bg = bg_base, fg = p.text },
  }

  require("lualine").setup({
    options = {
      theme = theme,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "branch",
          icon = "",
          seperator = "",
          padding = { left = 1, right = 1 },
        },
        {
          "diff",
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
          symbols = {
            added = "+",
            modified = "~",
            removed = "-",
          },
        },
        {
          "diagnostics",
          symbols = {
            error = "󰅚 ",
            warn = "󰀪 ",
            info = "󰋽 ",
            hint = "󰌶 ",
          },
        },
      },
      lualine_c = { "buffers" },
      lualine_x = {
        {
          function() return "" end,
          cond = function() return vim.bo.readonly or not vim.bo.modifiable end,
        },
        "encoding",
        "fileformat",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  })
end)


-- ==========
-- Editor
-- ==========

local oil
local oil_ensure_setup = function()
  packadd({ "https://github.com/stevearc/oil.nvim" })

  if not oil then
    oil = require("oil")
    oil.setup({
      columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
      },
      use_default_keymaps = false,
      keymaps = {
        ["H"] = { "actions.parent", mode = "n" },
        ["L"] = { "actions.select", mode = "n" },
        ["<CR>"] = { "actions.select", mode = "n" },
        ["<Tab>"] = { "actions.preview", mode = "n" },
        ["."] = { "actions.open_cwd", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["<Leader>r"] = { "actions.refresh", mode = "n" },
      },
      view_options = { show_hidden = true },
    })
  end
end

keymap.map({ "n", "x" }, "<Leader>o", function()
  oil_ensure_setup()
  return "<Cmd>Oil<CR>"
end, { expr = true })

-- ==========
-- Editing
-- ==========

-- completion
-- autocmd({ "CmdlineEnter", "InsertEnter" }, {
--   once = true,
--   callback = function()
--     packadd({
--       "https://github.com/saghen/blink.lib",
--       "https://github.com/saghen/blink.cmp",
--     })
--
--     local cmp = require("blink.cmp")
--     cmp.build():pwait()
--     cmp.setup({
--       keymap = {
--         preset = "none",
--         ["<C-n>"] = { "select_next", "fallback" },
--         ["<C-p>"] = { "select_prev", "fallback" },
--         ["<Tab>"] = { "select_next", "fallback" },
--         ["<S-Tab>"] = { "select_prev", "fallback" },
--         ["<Enter>"] = { "accept", "fallback" },
--         ["<C-u>"] = { "scroll_documentation_up", "fallback" },
--         ["<C-d>"] = { "scroll_documentation_down", "fallback" },
--       },
--       cmdline = {
--         keymap = {
--           preset = "inherit",
--           ["<Tab>"] = { "show", "select_next", "fallback" },
--           ["<Enter>"] = { "fallback" },
--         },
--         completion = {
--           list = { selection = { preselect = false, auto_insert = true } },
--           menu = { auto_show = true },
--         },
--       },
--       completion = {
--         list = { selection = { preselect = false, auto_insert = false } },
--         menu = { auto_show = true },
--         documentation = { auto_show = true, auto_show_delay_ms = 0 },
--       }
--     })
--   end
-- })

lazy(function()
  packadd({ "https://github.com/nvim-treesitter/nvim-treesitter" })
  require("nvim-treesitter").install({
    "c",
    "cpp",
    "rust",
    "go",
    "lua",
    "python",
    "markdown",
    "markdown_inline",
  })
end)

lazy(function()
  packadd({ "https://github.com/neovim/nvim-lspconfig" })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  vim.lsp.enable({
    "clangd",
    "rust_analyzer",
    "gopls",
    "lua_ls",
  })
end)

autocmd({ "CmdlineEnter", "InsertEnter" }, {
  once = true,
  callback = function()
    packadd({
      "https://github.com/nvim-mini/mini.pairs",
      "https://github.com/nvim-mini/mini.surround",
    })

    require("mini.pairs").setup()
    require("mini.surround").setup()
  end
})

autocmd("BufReadPost", {
  once = true,
  pattern = "*.md",
  callback = function()
    packadd({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
    require("render-markdown").setup({ completions = { lsp = { enabled = true } } })
  end
})

local multicursor
local multicursor_ensure_setup = function()
  packadd({ "https://github.com/jake-stewart/multicursor.nvim" })

  if not multicursor then
    multicursor = require("multicursor-nvim")
    multicursor.setup()
    multicursor().addKeymapLayer(function(layerset)
      layerset({ "n" }, "<Esc>", function()
        if not multicursor().cursorsEnabled() then
          multicursor().enableCursors()
        else
          multicursor().clearCursors()
        end
      end)
    end)
  end
end

keymap.map({ "n", "x", "i" }, "<M-k>", function()
  multicursor_ensure_setup()
  multicursor.lineAddCursor(-1)
end)

keymap.map({ "n", "x", "i" }, "<M-j>", function()
  multicursor_ensure_setup()
  multicursor.lineAddCursor(1)
end)

keymap.map({ "n", "x", "i" }, "<M-p>", function()
  multicursor_ensure_setup()
  multicursor.matchAddCursor(-1)
end)

keymap.map({ "n", "x", "i" }, "<M-n>", function()
  multicursor_ensure_setup()
  multicursor.lineAddCursor(1)
end)

keymap.map({ "n", "x", "i" }, "<M-a>", function()
  multicursor_ensure_setup()
  multicursor.matchAllAddCursors()
end)

keymap.map("n", "<M-|>", function()
  multicursor_ensure_setup()
  multicursor.alignCursors()
end)

keymap.map("x", "I", function()
  multicursor_ensure_setup()
  multicursor.insertVisual()
end)

keymap.map("x", "A", function()
  multicursor_ensure_setup()
  multicursor.appendVisual()
end)

-- ==========
-- MISC
-- ==========

lazy(function()
  packadd({ "https://github.com/mrjones2014/smart-splits.nvim" })

  local sp = require("smart-splits")
  sp.setup()

  local mappings = {
    ["<C-k>"] = sp.move_cursor_up,
    ["<C-j>"] = sp.move_cursor_down,
    ["<C-h>"] = sp.move_cursor_left,
    ["<C-l>"] = sp.move_cursor_right,

    ["<C-S-Up>"] = sp.resize_up,
    ["<C-S-Down>"] = sp.resize_down,
    ["<C-S-Left>"] = sp.resize_left,
    ["<C-S-Right>"] = sp.resize_right,

    ["<C-x>k"] = function()
      sp.swap_buf_up()
      vim.cmd("wincmd k")
    end,
    ["<C-x>j"] = function()
      sp.swap_buf_down()
      vim.cmd("wincmd j")
    end,
    ["<C-x>h"] = function()
      sp.swap_buf_left()
      vim.cmd("wincmd h")
    end,
    ["<C-x>l"] = function()
      sp.swap_buf_right()
      vim.cmd("wincmd l")
    end,
  }
  for lhs, rhs in pairs(mappings) do
    keymap.map({ "n", "x" }, lhs, rhs)
  end
end)

autocmd("InsertEnter", {
  once = true,
  callback = function()
    packadd({ "https://github.com/stevearc/conform.nvim" })
    require("conform").setup({ format_after_save = { lsp_format = "fallback" } })
  end
})

autocmd("FileType", {
  once = true,
  callback = function()
    packadd({ "https://github.com/stevearc/quicker.nvim" })

    local quicker = require("quicker")
    keymap.map("n", "<Leader>q", function() quicker.toggle() end)
    keymap.map("n", "<Leader>l", function() quicker.toggle({ loclist = true }) end)
    quicker.setup({
      keys = {
        { "<Tab>", function() quicker.toggle_expand({ before = 4, after = 4 }) end },
      },
      highlight = { lsp = false },
    })
  end
})

local overseer
local overseer_ensure_setup = function()
  packadd({ "https://github.com/stevearc/overseer.nvim" })

  if not overseer then
    overseer = require("overseer")
    overseer.setup()
  end
end

keymap.map({ "n", "x" }, "<Leader>tt", function()
  overseer_ensure_setup()
  return "<Cmd>OverseerToggle<CR>"
end, { expr = true })

keymap.map({ "n", "x" }, "<Leader>tr", function()
  overseer_ensure_setup()
  return "<Cmd>OverseerRun<CR>"
end, { expr = true })

keymap.map({ "n", "x" }, "<Leader>ta", function()
  overseer_ensure_setup()
  return "<Cmd>OverseerTaskAction<CR>"
end, { expr = true })

local neogit
keymap.map({ "n", "x" }, "<Leader>g", function()
  packadd({ "https://github.com/neogitorg/neogit" })

  if not neogit then
    neogit = require("neogit")
  end
  return "<Cmd>Neogit<CR>"
end, { expr = true })

local fzf_lua
local fzf_lua_ensure_setup = function()
  packadd({ "https://github.com/ibhagwan/fzf-lua" })

  if not fzf_lua then
    fzf_lua = require("fzf-lua")
    fzf_lua.register_ui_select()
    fzf_lua.setup({
      { "hide" },
      winopts = {
        relative = "editor",
        row = 1,
        col = 0,
        width = 1,
        height = 0.45,
        border = "rounded",
        preview = {
          hidden = false,
          layout = "horizontal",
          horizontal = "right:50%",
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse-list",
      },
      fzf_colors = {
        ["bg"] = "-1",
        ["gutter"] = "-1",
      },
    })
  end
end

keymap.map("n", "gr", function()
  fzf_lua_ensure_setup()
  fzf_lua.lsp_references()
end)

keymap.map("n", "gd", function()
  fzf_lua_ensure_setup()
  fzf_lua.lsp_definitions()
end)

keymap.map("n", "gi", function()
  fzf_lua_ensure_setup()
  fzf_lua.lsp_implementations()
end)

keymap.map("n", "<Leader>s", function()
  fzf_lua_ensure_setup()
  fzf_lua.lsp_document_symbols()
end)

keymap.map("n", "<Leader>S", function()
  fzf_lua_ensure_setup()
  fzf_lua.lsp_workspace_symbols()
end)

keymap.map("n", "<Leader>/", function()
  fzf_lua_ensure_setup()
  fzf_lua.live_grep()
end)

keymap.map("n", "<Leader>f", function()
  fzf_lua_ensure_setup()
  fzf_lua.files({ cwd = vim.uv.cwd() })
end)

keymap.map("n", "<Leader>F", function()
  fzf_lua_ensure_setup()
  fzf_lua.files({ cwd = require("util").getroot() })
end)

keymap.map("n", "<Leader>h", function()
  fzf_lua_ensure_setup()
  fzf_lua.oldfiles({
    cwd = vim.uv.cwd(),
    cwd_only = true,
    include_current_session = true,
  })
end)

keymap.map("n", "<Leader>H", function()
  fzf_lua_ensure_setup()
  fzf_lua.oldfiles({
    cwd = require("util").getroot(),
    cwd_only = true,
    include_current_session = true,
  })
end)

local grug_far
local grug_far_ensure_setup = function()
  packadd({ "https://github.com/MagicDuck/grug-far.nvim" })

  if not grug_far then
    grug_far = require("grug-far")
    grug_far.setup({
      windowCreationCommand = "botright split"
    })
  end
end

keymap.map("n", "<Leader>r", function()
  grug_far_ensure_setup()
  return "<Cmd>GrugFar<CR>"
end, { expr = true })
