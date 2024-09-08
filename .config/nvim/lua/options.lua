-- For more opts: ":help option-list"
local opt = vim.opt

-- Visual effects --
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.wrap = false
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
-- opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.inccommand = "split"

-- Text editing --
opt.mouse = "a"
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- System I/O --
opt.undofile = false
opt.scrolloff = 3
-- vim.schedule(
--   function()
--     opt.clipboard = "unnamedplus"
--   end
-- )
opt.updatetime = 100
opt.timeout = false
opt.ttimeoutlen = 0
