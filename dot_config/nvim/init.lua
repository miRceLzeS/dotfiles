-- [INFO] global
local G = vim.g

G.mapleader = " "
G.maplocalleader = "\\"

-- [INFO] option
local opt = vim.opt

-- visual effect
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
opt.linebreak = true -- line will break at suitable character if true
opt.breakindent = true -- the new visual line will be indented
opt.showbreak = "≪ "

-- indent
opt.expandtab = true -- number of spaces will be inserted replacing a tab
local tab_spaces = 2
opt.tabstop = tab_spaces -- number of visual spaces of a tab
opt.shiftwidth = tab_spaces -- number of spaces when auto indent
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
  else return ""
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

map({ "n", "x" }, "gh", "0")
map({ "n", "x" }, "gl", "$")

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

-- buffer
map({ "n", "x" }, "<Leader>b[", "<Cmd>bprevious<CR>", { desc = "Goto prievous buffer" })
map({ "n", "x" }, "<Leader>b]", "<Cmd>bnext<CR>", { desc = "Goto next buffer" })

-- window
map({ "n", "x" }, "<Leader>wh", "<C-w>h", { desc = "Goto window left" })
map({ "n", "x" }, "<Leader>wl", "<C-w>l", { desc = "Goto window right" })
map({ "n", "x" }, "<Leader>wk", "<C-w>k", { desc = "Goto window up" })
map({ "n", "x" }, "<Leader>wj", "<C-w>j", { desc = "Goto window down" })

map({ "n", "x" }, "<Leader>ws", function()
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok then return end

  local expr = op_motion_expr("split", key)
  if expr == "" then return end

  vim.cmd(expr)
end, { desc = "Split window to direction" })

map({ "n", "x" }, "<Leader>wn", function()
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok then return end

  local expr = op_motion_expr("new", key)
  if expr == "" then return end

  vim.cmd(expr)
end, { desc = "Create new window at direction" })

map({ "n", "x" }, "<Leader>wo", "<Cmd>only<CR>", { desc = "Close other windows" })

-- tab
map({ "n", "x" }, "<Leader><Tab>[", "<Cmd>tabprevious<CR>")
map({ "n", "x" }, "<Leader><Tab>]", "<Cmd>tabnext<CR>")

map({ "n", "x" }, "<Leader><Tab>n", "<Cmd>tabnew<CR>")

map({ "n", "x" }, "<Leader><Tab>o", "<Cmd>tabonly<CR>", { desc = "Close other tabs" })

-- file
map({ "n", "x" }, "<Leader>fn", "<Cmd>enew<CR>", { desc = "Create new file" })
