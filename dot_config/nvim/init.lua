-- [INFO] global
local G = vim.g
G.mapleader = " "
G.maplocalleader = "\\"

-- [INFO] option
local opt = vim.opt
-- appearance
opt.colorcolumn = "64"
opt.cursorline = true
opt.inccommand = "split"
opt.listchars = { tab = "▎ ", trail = "·", nbsp = "␣" }
opt.list = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.showmode = false
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.winborder = "rounded"
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
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.confirm = true
opt.mouse = "nv"
opt.swapfile = false
opt.timeoutlen = 512
opt.undofile = true
opt.updatetime = 256

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

function cleancmd()
  vim.api.nvim_echo({ { "" } }, false, {})
  vim.cmd("redraw")
end
-- enhance
map("n", "<Esc>", "<Cmd>nohlsearch<CR>")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
-- customize
map("n", "U", "<C-r>")
map({ "n", "v" }, "gh", "0")
map({ "n", "v" }, "gl", "$")
map("n", "<M-u>", "<Cmd>m .-2<CR>==", { desc = "move current line up" })
map("n", "<M-d>", "<Cmd>m .+1<CR>==", { desc = "move current line down" })
map("v", "<M-u>", ":m '<-2<CR>gv=gv", { desc = "move current line up" })
map("v", "<M-d>", ":m '>+1<CR>gv=gv", { desc = "move current line down" })
map("i", "<M-u>", "<Esc><Cmd>m .-2<CR>==gi", { desc = "move current line up" })
map("i", "<M-d>", "<Esc><Cmd>m .+1<CR>==gi", { desc = "move current line down" })
-- toggle
map({ "n", "v" }, "<leader>tw", function()
  local wo = vim.wo
  wo.wrap = not wo.wrap
  -- [TODO] change to autocmd
  wo.colorcolumn = wo.wrap and "" or "64"
end, { desc = "toggle wrap" })
-- window
map({ "n", "v" }, "<leader>wh", "<C-w>h", { desc = "Goto window left" })
map({ "n", "v" }, "<leader>wl", "<C-w>l", { desc = "Goto window right" })
map({ "n", "v" }, "<leader>wk", "<C-w>k", { desc = "Goto window up" })
map({ "n", "v" }, "<leader>wj", "<C-w>j", { desc = "Goto window down" })
map({ "n", "v" }, "<leader>ws", function()
  vim.api.nvim_echo({ { "(← h | → l | ↑ k | ↓ j)" } }, false, {})
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok then return end
  if key == "h" then
    vim.cmd("leftabove vsplit")
  elseif key == "l" then
    vim.cmd("rightbelow vsplit")
  elseif key == "k" then
    vim.cmd("aboveleft split")
  elseif key == "j" then
    vim.cmd("botright split")
  else cleancmd() return
  end
  vim.cmd("wincmd " .. key)
  cleancmd()
end, { desc = "split window to direction" })
