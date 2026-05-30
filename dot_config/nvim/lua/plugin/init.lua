local lz = require("plugin.lz")

-- [NOTE] loaded immediately
lz.pack({
  { src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
  { src = "https://github.com/saghen/blink.lib", name = "blink.lib" },
}, function()
  -- === color scheme ===
  require("rose-pine").setup({ styles = { transparency = false } })
  vim.cmd.colorscheme("rose-pine")

  -- === icon ===
  require("nvim-web-devicons").setup()
end)

-- [NOTE] loaded lazily
lz.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
  { src = "https://github.com/mrjones2014/smart-splits.nvim", name = "smart-splits" },
  { src = "https://github.com/romus204/tree-sitter-manager.nvim", name = "tree-sitter-manager" },
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
  { src = "https://github.com/nvim-mini/mini.pairs", name = "mini.pairs" },
  { src = "https://github.com/saghen/blink.cmp", name = "blink.cmp" },
  { src = "https://github.com/stevearc/oil.nvim", name = "oil" },
})

lz.very_lazy("lualine", function()
  require("lualine").setup({ options = { theme = "rose-pine" } })
end)

lz.very_lazy("smart-splits", function()
  local sp = require("smart-splits")
  sp.setup()

  local mappings = {
    ["<C-k>"] = sp.move_cursor_up,
    ["<C-j>"] = sp.move_cursor_down,
    ["<C-h>"] = sp.move_cursor_left,
    ["<C-l>"] = sp.move_cursor_right,

    ["<C-Up>"] = sp.resize_up,
    ["<C-Down>"] = sp.resize_down,
    ["<C-Left>"] = sp.resize_left,
    ["<C-Right>"] = sp.resize_right,

    ["<C-x>k"] = function() sp.swap_buf_up() vim.cmd("wincmd k") end,
    ["<C-x>j"] = function() sp.swap_buf_down() vim.cmd("wincmd j") end,
    ["<C-x>h"] = function() sp.swap_buf_left() vim.cmd("wincmd h") end,
    ["<C-x>l"] = function() sp.swap_buf_right() vim.cmd("wincmd l") end,
  }
  for lhs, rhs in pairs(mappings) do
    require("keymap").map({ "n", "x" }, lhs, rhs)
  end
end)

lz.very_lazy("tree-sitter-manager", function()
  require("tree-sitter-manager").setup({
    ensure_installed = {
      "c",
      "cpp",
      "rust",
      "go",
      "lua",
      "python",
      "markdown",
      "markdown_inline",
    },
  })
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

lz.event({ "CmdlineEnter", "InsertEnter" }, "blink.cmp", function()
  local cmp = require("blink.cmp")
  cmp.build():pwait()
  cmp.setup({
    keymap = {
      preset = "none",
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<Shift><Tab>"] = { "select_prev", "fallback" },
      ["<Enter>"] = { "accept", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    cmdline = {
      keymap = {
        preset = "inherit",
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
end, { once = true })

lz.very_lazy("oil", function()
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
      ["L"] = "actions.select",
      ["<CR>"] = "actions.select",
      ["<Tab>"] = "actions.preview",
      ["<Leader>o."] = { "actions.open_cwd", mode = "n" },
      ["<Leader>oq"] = { "actions.close", mode = "n" },
      ["<Leader>or"] = { "actions.refresh", mode = "n" },
    },
    view_options = {
      show_hidden = true,
    },
  })
  require("keymap").map("n", "<Leader>o", "<Cmd>Oil<CR>")
end)
