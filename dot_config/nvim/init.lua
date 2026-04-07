-- [INFO] global
local G = vim.g

G.mapleader = " "
G.maplocalleader = "\\"

-- [INFO] option
local opt = vim.opt -- visual effect
opt.colorcolumn = "64"
opt.cursorline = true
opt.inccommand = "split"
opt.jumpoptions = "clean,view"
opt.laststatus = 3 -- global status line
opt.termguicolors = true
opt.showmode = false
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.shortmess:append("aIc")
opt.winborder = "rounded"

opt.listchars = { tab = "▎ ", trail = "·", nbsp = "␣" }
opt.list = true

opt.number = true
opt.relativenumber = true

-- split
opt.splitbelow = true
opt.splitright = true

-- wrap
opt.wrap = false
opt.linebreak = true -- line will break at suitable character if true opt.breakindent = true -- the new visual line will be indented
opt.showbreak = "≪ "

-- indent
opt.expandtab = true         -- number of spaces will be inserted replacing a tab
local tab_spaces = 2
opt.tabstop = tab_spaces     -- number of visual spaces of a tab
opt.shiftwidth = tab_spaces  -- number of spaces when auto indent
opt.softtabstop = tab_spaces -- number of spaces of cursor's movement

-- search: ignore case unless upper case character is typed
opt.ignorecase = true
opt.smartcase = true

-- io
opt.autoread = true
opt.autowrite = true
opt.confirm = true
opt.mouse = "nv"
opt.swapfile = false
opt.timeoutlen = 512
opt.undofile = true
opt.updatetime = 256

-- motion
opt.iskeyword:append("_", "-", ".")

-- [INFO] keymap

-- keymap util

function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function unmap(mode, lhs, opts)
  map(mode, lhs, "<Nop>", opts)
end

function delmap(mode, lhs, opts)
  pcall(vim.keymap.del, mode, lhs, opts)
end

function op_motion_expr(op, motion)
  if not op then return "" end

  if motion == "h" then
    return string.format("leftabove v%s", op)
  elseif motion == "l" then
    return string.format("rightbelow v%s", op)
  elseif motion == "k" then
    return string.format("aboveleft %s", op)
  elseif motion == "j" then
    return string.format("%s", op)
  else
    return ""
  end
end

-- unmap

unmap({ "n", "v" }, "s")

-- enhance

map("n", "<Esc>", "<Cmd>nohlsearch<CR>")

map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- customize

map("n", "U", "<C-r>")

map({ "n", "x", "o" }, "gh", "0")
map({ "n", "x", "o" }, "gl", "$")

map("n", "<M-u>", "<Cmd>m .-2<CR>==", { desc = "Move current line up" })
map("n", "<M-d>", "<Cmd>m .+1<CR>==", { desc = "Move current line down" })
map("x", "<M-u>", ":m '<-2<CR>gv=gv", { desc = "Move current line up" })
map("x", "<M-d>", ":m '>+1<CR>gv=gv", { desc = "Move current line down" })
map("i", "<M-u>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "Move current line up" })
map("i", "<M-d>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "Move current line down" })

-- toggle
map({ "n", "x" }, "<leader>tw", function()
  local wo = vim.wo

  wo.wrap = not wo.wrap
  wo.colorcolumn = wo.wrap and "" or "64" -- [TODO] change to autocmd
end, { desc = "toggle wrap" })

-- yank
map("x", "p", '"_dP')
map("v", "<Leader>y", '"+y')

-- window
map({ "n", "x" }, "<C-h>", "<C-w>h", { desc = "Goto window left" })
map({ "n", "x" }, "<C-l>", "<C-w>l", { desc = "Goto window right" })
map({ "n", "x" }, "<C-k>", "<C-w>k", { desc = "Goto window up" })
map({ "n", "x" }, "<C-j>", "<C-w>j", { desc = "Goto window down" })

map({ "n", "x" }, "<Leader>w", function()
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok then return end

  local expr = op_motion_expr("split", key)
  if expr == "" then return end

  vim.cmd(expr)
end, { desc = "Split window to direction" })

map({ "n", "x" }, "<Leader>wo", "<Cmd>only<CR>", { desc = "Close other windows" })

-- tab
map({ "n", "x" }, "[<Tab>", "<Cmd>tabprevious<CR>")
map({ "n", "x" }, "]<Tab>", "<Cmd>tabnext<CR>")

map({ "n", "x" }, "<Leader><Tab>n", "<Cmd>tabnew<CR>")

map({ "n", "x" }, "<Leader><Tab>o", "<Cmd>tabonly<CR>", { desc = "Close other tabs" })

-- plugin manager
map({ "n" }, "<Leader>pu", "<Cmd>lua vim.pack.update()<CR>", { desc = "Update plugins" })

-- [INFO] plugin
local pack = vim.pack
local gh = function(name) return "https://github.com/" .. name end
local setup = function(name, opts) require(name).setup(opts or {}) end
local autocmd = vim.api.nvim_create_autocmd

-- color scheme
pack.add({
  { src = gh("miRceLzeS/daibanana.nvim"), name = "daibanana" },
}, { load = true })
setup("daibanana", { transparent = true })
vim.cmd("colorscheme daibanana")

-- icon
pack.add({ gh("nvim-tree/nvim-web-devicons") }, { load = true })
setup("nvim-web-devicons")

-- status line
pack.add({ gh("nvim-lualine/lualine.nvim") })
setup("lualine", { options = { theme = "daibanana" } })

pack.add({ gh("stevearc/oil.nvim") }, { load = true })
setup("oil", {
  use_default_keymaps = false,
  keymaps = {
    ["H"] = { "actions.parent", mode = "n" },
    ["L"] = "actions.select",
    ["<CR>"] = "actions.select",
    ["<Leader>o."] = { "actions.open_cwd", mode = "n" },
    ["<Leader>oq"] = { "actions.close", mode = "n" },
    ["<Leader>or"] = { "actions.refresh", mode = "n" },
  },
  view_options = {
    show_hidden = true,
  },
})
map("n", "<Leader>o", "<Cmd>Oil<CR>")

-- completion
autocmd({ "CmdlineEnter", "InsertEnter" }, {
  once = true,
  callback = function()
    setup("blink.cmp", {
      completion = {
        documentation = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          }
        },
      },
      keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      signature = { enabled = true },
    })
  end,
})
pack.add({
  {
    src = gh("saghen/blink.cmp"),
    version = vim.version.range("1.*"),
  },
})

-- treesitter
local ensured_installed = { "rust", "go", "lua" }

autocmd({ "PackChanged" }, {
  once = true,
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})
autocmd({ "FileType" }, {
  pattern = "*",
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})
pack.add({
  {
    src = gh("nvim-treesitter/nvim-treesitter"),
    version = "main",
  },
})
require("nvim-treesitter").install(ensured_installed)

-- lsp
local lsp = vim.lsp
local installed = { "lua_ls", "gopls", "rust_analyzer" }
pack.add({ gh("neovim/nvim-lspconfig") })
lsp.enable(installed)

autocmd({ "CmdlineEnter", "InsertEnter" }, {
  once = true,
  callback = function()
    setup("mini.pairs", { modes = { command = true } })
    setup("mini.surround", { n_lines = 32 })
  end,
})
pack.add({
  gh("nvim-mini/mini.pairs"),
  gh("nvim-mini/mini.surround"),
})

delmap({ "n", "x" }, "gra")
delmap({ "n", "x" }, "gri")
delmap({ "n", "x" }, "grn")
delmap({ "n", "x" }, "grr")
delmap({ "n", "x" }, "grt")
delmap({ "n", "x" }, "grx")
delmap({ "n", "x" }, "g0")
delmap({ "i" }, "<C-s>")

-- conform
pack.add({ gh("stevearc/conform.nvim") })
setup("conform", {
  format_after_save = {
    lsp_format = "fallback",
  },
})

-- picker
pack.add({ gh("ibhagwan/fzf-lua") })
setup("fzf-lua", {
  winopts  = {
    width   = 0.8,
    height  = 0.9,
    preview = {
      hidden       = false,
      vertical     = "up:45%",
      horizontal   = "right:50%",
      layout       = "flex",
      flip_columns = 64,
      delay        = 10,
      winopts      = { number = false },
    },
  },
  keymap   = {
    builtin = {
      true,
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
    fzf = {
      true,
      ["ctrl-d"] = "preview-page-down",
      ["ctrl-u"] = "preview-page-up",
      ["ctrl-q"] = "select-all+accept",
    },
  },
  fzf_opts = {
    ["--layout"] = "reverse-list",
  },
})

function workspace_root()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config and client.config.root_dir and client.config.root_dir ~= "" then
      return client.config.root_dir
    end
  end
  return vim.fn.getcwd()
end

map({ "n", "x" }, "gr", "<Cmd>FzfLua lsp_references<CR>", { desc = "Goto references" })
map({ "n", "x" }, "gd", "<Cmd>FzfLua lsp_definitions<CR>", { desc = "Goto definition" })
map({ "n", "x" }, "gt", "<Cmd>FzfLua lsp_typedefs<CR>", { desc = "Goto type definition" })
map({ "n", "x" }, "gi", "<Cmd>FzfLua lsp_implementations<CR>", { desc = "Goto implementations" })
map({ "n", "x" }, "<Leader>r", lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "x" }, "<Leader>b", "<Cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
map({ "n", "x" }, "<Leader>f", "<Cmd>FzfLua files cwd=.<CR>", { desc = "Find files" })
map({ "n", "x" }, "<Leader>F", function()
  require("fzf-lua").files({ cwd = workspace_root() })
end, { desc = "Find files" })
map({ "n", "x" }, "<Leader>b", "<Cmd>FzfLua buffers<CR>", { desc = "Find buffers" })
map({ "n", "x" }, "<Leader>/", "<Cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
map({ "n", "x" }, "<Leader>s", "<Cmd>FzfLua lsp_document_symbols<CR>", { desc = "Buffer-wide symbols" })
map({ "n", "x" }, "<Leader>S", "<Cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace-wide symbols" })
map({ "n", "x" }, "<Leader>c", "<Cmd>FzfLua lsp_code_actions<CR>", { desc = "Code actions" })
map({ "n", "x" }, "<Leader>d", "<Cmd>FzfLua lsp_document_diagnostics<CR>", { desc = "Buffer-wide diagnostics" })
map({ "n", "x" }, "<Leader>D", "<Cmd>FzfLua lsp_workspace_diagnostics<CR>", { desc = "Workspace-wide diagnostics" })
