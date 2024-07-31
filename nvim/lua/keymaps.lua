-- I really want to simply named them "x" instead of "mode_x" :(
local mode_n = "n"
local mode_v = "v"
local mode_i = "i"

-- |mode|shortcut|operation|desc|
local mappings = {
    { { mode_n, mode_v }, "s", "<nop>", "Why would I need two 'x'?" },
    -- moving
    { { mode_n, mode_v, mode_i }, "<C-e>", "3<C-e>", "Scroll window downward" },
    { { mode_n, mode_v, mode_i }, "<C-y>", "3<C-y>", "Scroll window upward" },
    { { mode_n, mode_v }, "<tab>wh", ":wincmd h<CR>", "Move to left window"},
    { { mode_n, mode_v }, "<tab>wj", ":wincmd j<CR>", "Move to bottom window"},
    { { mode_n, mode_v }, "<tab>wk", ":wincmd k<CR>", "Move to up window"},
    { { mode_n, mode_v }, "<tab>wl", ":wincmd l<CR>", "Move to right window"},
    -- window split
    { { mode_n, mode_v }, "<leader>sh", ":leftabove vsplit new<CR>:wincmd h<CR>", "Split to left" },
    { { mode_n, mode_v }, "<leader>sj", ":belowright split new<CR>:wincmd j<CR>", "Split to bottom" },
    { { mode_n, mode_v }, "<leader>sk", ":topleft split new<CR>:wincmd k<CR>", "Split to up" },
    { { mode_n, mode_v }, "<leader>sl", ":rightbelow vsplit new<CR>:wincmd l<CR>", "Split to right" },
    -- window manage
    { { mode_n, mode_v }, "<C-h>", ":vertical resize -3<CR>", "Decrease current window width" },
    { { mode_n, mode_v }, "<C-j>", ":resize -3<CR>", "Decrease current window height" },
    { { mode_n, mode_v }, "<C-k>", ":resize +3<CR>", "Increase current window height" },
    { { mode_n, mode_v }, "<C-l>", ":vertical resize +3<CR>", "Increase current window width" },
    { { mode_n, mode_v }, "<C-S>h", "<C-W>H", "Exchange current window to the left"},
    { { mode_n, mode_v }, "<C-S>j", "<C-W>J", "Exchange current window to the bottom"},
    { { mode_n, mode_v }, "<C-S>k", "<C-W>K", "Exchange current window to the up"},
    { { mode_n, mode_v }, "<C-S>l", "<C-W>L", "Exchange current window to the right"},
}

-- vim.keymap.set({"n", "v"}, "sp", ":split<CR>", { noremap = true, silent = true })
for _, entry in ipairs(mappings) do
    local mode, shortcut, operation, entry_desc = unpack(entry)
    vim.keymap.set(mode, shortcut, operation, { desc = entry_desc, noremap = true, silent = true })
end
