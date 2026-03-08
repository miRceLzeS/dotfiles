local M = {}
M.opt = vim.opt

-- appearance
M.opt.termguicolors = true
M.opt.number = true
M.opt.relativenumber = true
M.opt.signcolumn = "yes"
M.opt.list = true
M.opt.listchars = { tab = "▎ ", trail = "·", nbsp = "␣" }
M.opt.inccommand = "split"
M.opt.showmode = false
M.opt.winborder = "rounded"
M.opt.colorcolumn = "64"

-- text editing
M.opt.breakindent = true
M.opt.ignorecase = true
M.opt.smartcase = true
M.opt.scrolloff = 4
M.opt.iskeyword:remove({ "_", "-" })

M.opt.expandtab = true -- number of spaces will be inserted replacing a tab
local tab_spaces = 2
M.opt.tabstop = tab_spaces -- number of visual spaces of a tab
M.opt.shiftwidth = tab_spaces -- number of spaces when auto indent
M.opt.softtabstop = tab_spaces -- number of spaces of cursor's movement
M.opt.linebreak = true
M.opt.breakindent = true
M.opt.showbreak = "↪ "

-- io
M.opt.autoread = true
M.opt.undofile = true
M.opt.updatetime = 250
M.opt.timeoutlen = 500
M.opt.confirm = true
M.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
M.opt.swapfile = false

-- misc
M.opt.mouse = "nv"

return M
