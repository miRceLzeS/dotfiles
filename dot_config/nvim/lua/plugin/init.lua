local keymap = require("keymap")

-- [NOTE] builtin plugins
vim.cmd.packadd("nvim.undotree")
keymap.map("n", "<Leader>uu", "<Cmd>Undotree<CR>")

-- [NOTE] custom plugins
-- === lazy wrapper ===
local lz = require("plugin.lz")

-- [NOTE] loaded immediately
lz.pack({
  { src = "https://github.com/rose-pine/neovim",                name = "rose-pine" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons",     name = "nvim-web-devicons" },
  { src = "https://github.com/saghen/blink.lib",                name = "blink.lib" },
  { src = "https://github.com/stevearc/oil.nvim",               name = "oil" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
}, function()
  -- === color scheme ===
  require("rose-pine").setup({ styles = { transparency = true } })
  vim.cmd.colorscheme("rose-pine")

  -- === icon ===
  require("nvim-web-devicons").setup()

  -- === file explorer ===
  require("oil").setup({
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
  keymap.map("n", "<Leader>o", "<Cmd>Oil<CR>")

  -- === treesitter ===
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

-- [NOTE] loaded lazily
lz.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim",                 name = "lualine" },
  { src = "https://github.com/mrjones2014/smart-splits.nvim",             name = "smart-splits" },
  { src = "https://github.com/neovim/nvim-lspconfig",                     name = "nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.pairs",                      name = "mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.surround",                   name = "mini.surround" },
  { src = "https://github.com/saghen/blink.cmp",                          name = "blink.cmp" },
  { src = "https://github.com/stevearc/conform.nvim",                     name = "conform" },
  { src = "https://github.com/stevearc/quicker.nvim",                     name = "quicker" },
  { src = "https://github.com/stevearc/overseer.nvim",                    name = "overseer" },
  { src = "https://github.com/lewis6991/gitsigns.nvim",                   name = "gitsigns" },
  { src = "https://github.com/neogitorg/neogit",                          name = "neogit" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
  { src = "https://github.com/jake-stewart/multicursor.nvim",             name = "multicursor-nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua",                          name = "fzf-lua" },
  { src = "https://github.com/MagicDuck/grug-far.nvim",                   name = "grug-far" },
})

lz.very_lazy("lualine", function()
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

lz.very_lazy("smart-splits", function()
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

lz.very_lazy("nvim-lspconfig", function()
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

lz.event({ "CmdlineEnter", "InsertEnter" }, "mini.pairs", function()
  require("mini.pairs").setup()
end)

lz.event({ "CmdlineEnter", "InsertEnter" }, "mini.surround", function()
  require("mini.surround").setup()
end)

lz.event({ "CmdlineEnter", "InsertEnter" }, "blink.cmp", function()
  local cmp = require("blink.cmp")
  cmp.build():pwait()
  cmp.setup({
    keymap = {
      preset = "none",
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Enter>"] = { "accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    cmdline = {
      keymap = {
        preset = "inherit",
        ["<Tab>"] = { "show", "select_next", "fallback" },
        ["<Enter>"] = { "fallback" },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
        menu = { auto_show = true },
      },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      menu = { auto_show = true },
      documentation = { auto_show = true, auto_show_delay_ms = 0 },
    }
  })
end)

lz.event("FileType", "quicker", function()
  local quicker = require("quicker")
  keymap.map("n", "<Leader>q", function() quicker.toggle() end)
  keymap.map("n", "<Leader>l", function() quicker.toggle({ loclist = true }) end)
  quicker.setup({
    keys = {
      { "<Tab>", function() quicker.toggle_expand({ before = 4, after = 4 }) end },
    },
    highlight = { lsp = false },
  })
end, { pattern = "qf" })

lz.event("InsertEnter", "conform", function()
  require("conform").setup({ format_after_save = { lsp_format = "fallback" } })
end)

local overseer = function()
  return require("overseer")
end

lz.keys("overseer", function()
  overseer().setup()
end, {
  { { "n" }, "<Leader>tt", "<Cmd>OverseerToggle<CR>" },
  { { "n" }, "<Leader>tr", "<Cmd>OverseerRun<CR>" },
  { { "n" }, "<Leader>ta", "<Cmd>OverseerTaskAction<CR>" },
})

lz.very_lazy("gitsigns", function()
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

lz.keys("neogit", nil, {
  { { "n", "x" }, "<Leader>g", "<Cmd>Neogit<CR>" },
})

lz.event("BufReadPost", "render-markdown", function()
  require("render-markdown").setup({ completions = { lsp = { enabled = true } } })
end, { pattern = "*.md" })

local mc = function()
  return require("multicursor-nvim")
end

lz.keys("multicursor-nvim", function()
  mc().setup()
  mc().addKeymapLayer(function(layerset)
    layerset({ "n" }, "<Esc>", function()
      if not mc().cursorsEnabled() then
        mc().enableCursors()
      else
        mc().clearCursors()
      end
    end)
  end)
end, {
  { { "n", "x", "i" }, "<M-k>", function() mc().lineAddCursor(-1) end },
  { { "n", "x", "i" }, "<M-j>", function() mc().lineAddCursor(1) end },
  { { "n", "x", "i" }, "<M-p>", function() mc().matchAddCursor(-1) end },
  { { "n", "x", "i" }, "<M-n>", function() mc().matchAddCursor(1) end },
  { { "n", "x", "i" }, "<M-a>", function() mc().matchAllAddCursors() end },
  { { "n" },           "<M-|>", function() mc().alignCursors() end },
  { { "x" },           "I",     function() mc().insertVisual() end },
  { { "x" },           "A",     function() mc().appendVisual() end },
})

local fzf_lua = function()
  return require("fzf-lua")
end

lz.keys("fzf-lua", function()
  fzf_lua().setup({
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
end, {
  { { "n" }, "gr",        function() fzf_lua().lsp_references() end },
  { { "n" }, "gd",        function() fzf_lua().lsp_definitions() end },
  { { "n" }, "gi",        function() fzf_lua().lsp_implementations() end },
  { { "n" }, "<Leader>s", function() fzf_lua().lsp_document_symbols() end },
  { { "n" }, "<Leader>S", function() fzf_lua().lsp_workspace_symbols() end },
  { { "n" }, "<Leader>/", function() fzf_lua().live_grep() end },
  { { "n" }, "<Leader>f", function() fzf_lua().files({ cwd = vim.uv.cwd() }) end },
  { { "n" }, "<Leader>F", function() fzf_lua().files({ cwd = require("util").getroot() }) end },
  { { "n" }, "<Leader>h", function()
    fzf_lua().oldfiles({
      cwd = vim.uv.cwd(),
      cwd_only = true,
      include_current_session = true,
    })
  end },
  { { "n" }, "<Leader>H", function()
    fzf_lua().oldfiles({
      cwd = require("util").getroot(),
      cwd_only = true,
      include_current_session = true,
    })
  end },
})

local grug_far = function()
  return require("grug-far")
end

lz.keys("grug-far", function()
  grug_far().setup({
    windowCreationCommand = "botright split"
  })
end, {
  { { "n" }, "<Leader>r", "<Cmd>GrugFar<CR>" }
})
