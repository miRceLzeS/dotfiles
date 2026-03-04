local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.unmap(mode, lhs, opts)
  M.map(mode, lhs, "<Nop>", opts)
end

-- key bindings

M.map({ "n" }, "<Esc>", "<Cmd>nohlsearch<CR>")

M.map({ "n", "v", "i" }, "<M-w>", function()
  local opt = require("options").opt
  opt.wrap = not opt.wrap:get()
end)

M.map({ "n", "v" }, "<leader>l", "<C-w>h", { desc = "Goto window left" })
M.map({ "n", "v" }, "<leader>r", "<C-w>l", { desc = "Goto window right" })
M.map({ "n", "v" }, "<leader>u", "<C-w>k", { desc = "Goto window up" })
M.map({ "n", "v" }, "<leader>d", "<C-w>j", { desc = "Goto window down" })

M.map({ "n", "v" }, "<leader>wl", "<Cmd>leftabove vsplit<CR>", { desc = "vsplit left" })
M.map({ "n", "v" }, "<leader>wr", "<Cmd>rightbelow vsplit<CR>", { desc = "vsplit right" })
M.map({ "n", "v" }, "<leader>wu", "<Cmd>aboveleft split<CR>", { desc = "split up" })
M.map({ "n", "v" }, "<leader>wd", "<Cmd>botright split<CR>", { desc = "split down" })

return M
