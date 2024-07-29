vim.g.mapleader = " "

local opts = {
	noremap = true,	-- no recursive map, means preventing remap
	silent = true -- disabling the cmd output from showing up
}

local mode_n = "n"
local mode_v = "v"
local mode_i = "i"
local mappings = {
	-- { shortcut = "", operation = "", mode = {} },
	-- Cursor movement
	{ shortcut = "<leader>h",	operation = "<C-w>h",													mode = { mode_n, mode_v } },
	{ shortcut = "<leader>j",	operation = "<C-w>j", 													mode = { mode_n, mode_v } },
	{ shortcut = "<leader>k",	operation = "<C-w>k", 													mode = { mode_n, mode_v } },
	{ shortcut = "<leader>l",	operation = "<C-w>l", 													mode = { mode_n, mode_v } },
	{ shortcut = "<leader>x",	operation = "<C-w>x", 													mode = { mode_n, mode_v } },
	-- Text editing
	-- Commandline
	-- Window-relevant operation
	{ shortcut = "s",			operation = "<nop>",													mode = mode_n },
	{ shortcut = "sh",			operation = ":leftabove vsplit<CR>:wincmd h<CR>",						mode = mode_n },
	{ shortcut = "sj",			operation = ":split<CR>:wincmd j<CR>",									mode = mode_n },
	{ shortcut = "sk",			operation = ":leftabove split<CR>:wincmd k<CR>",						mode = mode_n },
	{ shortcut = "sl",			operation = ":vsplit<CR>:wincmd l<CR>",									mode = mode_n },
	{ shortcut = "<C-h>",		operation = ":vertical resize +2<CR>",									mode = mode_n },
	{ shortcut = "<C-j>",		operation = ":resize -2<CR>",											mode = mode_n },
	{ shortcut = "<C-k>",		operation = ":resize +2<CR>",											mode = mode_n },
	{ shortcut = "<C-l>",		operation = ":vertical resize -2<CR>",									mode = mode_n },
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode, mapping.shortcut, mapping.operation, opts)
end
