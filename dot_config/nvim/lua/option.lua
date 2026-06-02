-- [NOTE] vim.g
local G = vim.g

G.mapleader = " "
G.maplocalleader = "\\"

-- [NOTE] vim.opt
local opt = vim.opt

-- === appearence ===
opt.termguicolors = true
opt.shortmess:append("aIc")

opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

opt.laststatus = 3 -- global status line
opt.showmode = false

opt.scrolloff = 4
opt.list = true
opt.listchars = { tab = "▎ ", trail = "·", nbsp = "␣" }

opt.wrap = false
opt.breakindent = true
opt.linebreak = true -- line will break at suitable character if true opt.breakindent = true -- the new visual line will be indented
opt.showbreak = "≪ "

opt.cursorline = true
opt.colorcolumn = "100"

opt.expandtab = true         -- number of spaces will be inserted replacing a tab
local tab_spaces = 2
opt.tabstop = tab_spaces     -- number of visual spaces of a tab
opt.shiftwidth = tab_spaces  -- number of spaces when auto indent
opt.softtabstop = tab_spaces -- number of spaces of cursor's movement

opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

opt.splitbelow = true
opt.splitright = true
opt.winborder = "rounded"

-- === io ===
opt.autoread = true
opt.confirm = true
opt.mouse = "nv"
opt.swapfile = false
opt.timeoutlen = 500
opt.undofile = true
opt.updatetime = 250

-- === diagnostic ===
vim.diagnostic.config({ severity_sort = true })

-- === external ===
if vim.fn.executable("rg") then
  vim.opt.grepprg = "rg --vimgrep --smart-case"
end

-- === misc ===
opt.iskeyword:remove({ "_", "-", "." })
