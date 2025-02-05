vim.g.mapleader = " "
vim.g.localleader = "\\"

-- default opts:
-- nowait = true
local shared_opts = { noremap = true, silent = true }

-- :help vim.keymap.set
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- mode:
-- n - normal
-- i - insert
-- v - visual
-- c - command
-- r - replace
-- t - terminal
-- s - substitute
local mappings = {
  -- window
  { "n",               "<leader>wh",     ":leftabove vsplit | wincmd h<cr>",  { desc = "Split a window to left" } },
  { "n",               "<leader>wj",     ":botright split | wincmd j<cr>",    { desc = "Split a window to bottom" } },
  { "n",               "<leader>wk",     ":topleft split | wincmd k<cr>",     { desc = "Split a window to above" } },
  { "n",               "<leader>wl",     ":rightbelow vsplit | wincmd l<cr>", { desc = "Split a window to right" } },

  { "n",               "<M-w>h",         ":wincmd h<cr>",                     { desc = "Go to left window" } },
  { "n",               "<M-w>j",         ":wincmd j<cr>",                     { desc = "Go to below window" } },
  { "n",               "<M-w>k",         ":wincmd k<cr>",                     { desc = "Go to above window" } },
  { "n",               "<M-w>l",         ":wincmd l<cr>",                     { desc = "Go to right window" } },

  { "n",               "<S-w><Right>",   ":vertical resize +1<cr>",           { desc = "Increase window height" } },
  { "n",               "<S-w><Down>",    ":resize -1<cr>",                    { desc = "Decrease window weight" } },
  { "n",               "<S-w><Up>",      ":resize +1<cr>",                    { desc = "Increase window weight" } },
  { "n",               "<S-w><Left>",    ":vertical resize -1<cr>",           { desc = "Decrease window weight" } },

  { { "n", "i" },      "<M-j>",          "<esc>:move .+1<cr>==",              { desc = "Move current line down" } },
  { { "n", "i" },      "<M-k>",          "<esc>:move .-2<cr>==",              { desc = "Move current line up" } },
  { "x",               "<M-j>",          ":'<,'>move '>+<cr>gv=gv",           { desc = "Move selected lines up" } },
  { "x",               "<M-k>",          ":'<,'>move '<-2<cr>gv=gv",          { desc = "Move selected lines down" } },

  { "n",               "<M-w>[",         ":bprevious<cr>",                    { desc = "Go to previous buffer" } },
  { "n",               "<M-w>]",         ":bnext<cr>",                        { desc = "Go to next buffer" } },

  -- tab
  { "n",               "<leader><tab>n", ":tabnew<cr>",                       { desc = "Create new tab" } },
  { "n",               "<leader><tab>o", ":tabonly<cr>",                      { desc = "Close other tab" } },
  { "n",               "<leader><tab>d", ":tabclose<cr>",                     { desc = "Close current tab" } },
  { "n",               "<tab>[",         ":tabprevious<cr>",                  { desc = "Go to previous tab" } },
  { "n",               "<tab>]",         ":tabnext<cr>",                      { desc = "Go to next tab" } },

  -- diagnose
  { { "n", "i", "x" }, "<M-[>",          vim.diagnostic.goto_prev,            { desc = "Go to previous diagnostic message" } },
  { { "n", "i", "x" }, "<M-]>",          vim.diagnostic.goto_next,            { desc = "Go to next diagnostic message" } },

  -- clear highlights on search when pressing <esc>
  { "n",               "<esc>",          ":nohlsearch<cr>",                   { noremap = false } },

  -- auto scroll and unfold the line when finding
  { { "n", "x" },      "n",              "nzzzv" },
  { { "n", "x" },      "N",              "Nzzzv" },

  -- sweeter indent
  { "v",               "<",              "<gv" },
  { "v",               ">",              ">gv" },

  -- unmap
  { { "n", "v" },      "s",              "<nop>" },
  { "n",               "\\",             "<nop>" },
  { { "n", "i" },      "<F1>",           "<nop>" },
}

for _, entry in ipairs(mappings) do
  local modes, lhs, rhs, entry_opts = unpack(entry)
  opts = vim.tbl_deep_extend("force", shared_opts, entry_opts or {})
  vim.keymap.set(modes, lhs, rhs, opts)
end
