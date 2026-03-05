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
M.map({ "n" }, "U", "<C-r>")

M.map({ "n", "v", "i" }, "<M-w>", function()
  local opt = require("options").opt
  opt.wrap = not opt.wrap:get()
end)

M.map({ "n", "v" }, "<leader>wl", "<C-w>h", { desc = "Goto window left" })
M.map({ "n", "v" }, "<leader>wr", "<C-w>l", { desc = "Goto window right" })
M.map({ "n", "v" }, "<leader>wu", "<C-w>k", { desc = "Goto window up" })
M.map({ "n", "v" }, "<leader>wd", "<C-w>j", { desc = "Goto window down" })

M.map({ "n", "v" }, "<leader>wn", function()
  local ok, key = pcall(vim.fn.getcharstr)
  if not ok then return end
  if key == "l" then
    vim.cmd("leftabove vsplit")
  elseif key == "r" then
    vim.cmd("rightbelow vsplit")
  elseif key == "u" then
    vim.cmd("aboveleft split")
  elseif key == "d" then
    vim.cmd("botright split")
  end
end)

return M
