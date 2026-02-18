local opt = vim.opt

-- ui
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { tab = "⇥ ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.showmode = false
opt.ruler = false

-- text editing
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 4

opt.expandtab = true -- number of spaces will be inserted replacing a tab
local tab_spaces = 2
opt.tabstop = tab_spaces -- number of visual spaces of a tab
opt.shiftwidth = tab_spaces -- number of spaces when auto indent
opt.softtabstop = tab_spaces -- number of spaces of cursor's movement
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

-- diagnostic
vim.diagnostic.config({
  float = {
    border = "rounded",
    focusable = false,
    scope = "cursor",
    source = "if_many",
  },
  severity_sort = true,
  update_in_insert = false,
  virtual_text = false,
})

-- io
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 500
opt.confirm = true
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- misc
opt.mouse = ""

