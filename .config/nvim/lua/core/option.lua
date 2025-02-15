vim.g.have_nerd_font = true

-- :Inspect bug in v0.10.3
vim.hl = vim.highlight

-- :help xxx (where xxx should be within "vim.opt.xxx")
-- :help vim.opt
-- :help option-list
local opt = vim.opt

-- line number
opt.number = true
opt.relativenumber = true

opt.showmode = false

-- disable mouse click
opt.mouse = ""

-- auto indent when change line
opt.breakindent = true

-- indent behavior
opt.shiftround = true
opt.shiftwidth = 2

-- use spaces when tab
opt.expandtab = true

-- tab size
opt.tabstop = 2

-- searching will auto match case
opt.ignorecase = true
opt.smartcase = true

-- display brief info before every line
opt.signcolumn = "yes"

-- default split position
opt.splitright = true
opt.splitbelow = true

-- cursor and view position when split
opt.splitkeep = "screen"

-- :help list
-- :help listchars
-- set how neovim display some whitespace characters in editor
-- opt.list = true
-- opt.listchars = { tab = ' ·', trail = '↵', nbsp = '␣' }

-- preview when using :%s
opt.inccommand = "nosplit"

-- highlight the line that cursor on
opt.cursorline = true

-- line will continue in next line if too long
opt.wrap = false

-- change line at a convenient position so that a single word will no be splitted
opt.linebreak = true

-- number of lines that should remain above and below the cursor
opt.scrolloff = 5
opt.sidescrolloff = 5

-- completetion platte behavior in insertmode
opt.completeopt = "menu,menuone,preview,noselect"

-- maximum number of entries in a popup
opt.pumheight = 10

-- always require confirmation when exiting a modified buffer
opt.confirm = true

-- cursor coordinate
opt.ruler = false

-- save change history into files
opt.undofile = true
opt.undolevels = 10000

-- true color support
opt.termguicolors = true

-- waiting time of command
opt.timeoutlen = 500

-- clipboard
if (os.getenv("SSH_TTY") == nil)
then
  -- local env
  opt.clipboard:append("unnamedplus")
else
  -- remote access
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end
