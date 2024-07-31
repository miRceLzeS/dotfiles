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
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- System I/O --
opt.undofile = true
opt.scrolloff = 3
vim.schedule(
    function()
        opt.clipboard = "unnamedplus"
    end
)
opt.updatetime = 100
opt.timeout = false
opt.ttimeoutlen = 0
