vim.g.mapleader = " "

local opts = {
	noremap = true,	-- no recursive map, means preventing remap
	silent = true -- disabling the cmd output from showing up
}

-- :h vim.map.set() for more info
-- Normal mode
-- Window navigation
vim.keymap.set('n', '<Tab>h', '<C-w>h', opts) -- Navigate to left window
vim.keymap.set('n', '<Tab>j', '<C-w>j', opts) -- Navigate to bottom window
vim.keymap.set('n', '<Tab>k', '<C-w>k', opts) -- Navigate to up window
vim.keymap.set('n', '<Tab>l', '<C-w>l', opts) -- Navigate to right window

-- Resize window
vim.keymap.set('n', '<C-k>', ':resize -4<CR>', opts)
vim.keymap.set('n', '<C-j>', ':resize +4<CR>', opts)
vim.keymap.set('n', '<C-h>', ':vertical resize -4<CR>', opts)
vim.keymap.set('n', '<C-l>', ':vertical resize +4<CR>', opts)

local mode_n = "n"
local mode_v = "v"
local mode_i = "i"
local mappings = {
	-- Format: from | to | mode
	-- Window navigation
	{ from = "<Tab>h",	to = "<C-w>h",	mode = { mode_n, mode_v } }
	{ from = "<Tab>j",	to = "<C-w>j",	mode = { mode_n, mode_v } }
	{ from = "<Tab>k",	to = "<C-w>k",	mode = { mode_n, mode_v } }
	{ from = "<Tab>l",	to = "<C-w>l",	mode = { mode_n, mode_v } }

	-- Window resize
}
