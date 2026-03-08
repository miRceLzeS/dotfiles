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

M.map("n", "<Esc>", "<Cmd>nohlsearch<CR>")

M.map("n", "<M-u>", "<Cmd>m .-2<CR>==")
M.map("n", "<M-d>", "<Cmd>m .+1<CR>==")
M.map("v", "<M-u>", ":m '<-2<CR>gv=gv")
M.map("v", "<M-d>", ":m '>+1<CR>gv=gv")

M.map("n", "U", "<C-r>")

M.map("v", "<", "<gv")
M.map("v", ">", ">gv")

M.map("n", "<C-u>", "<C-u>zz")
M.map("n", "<C-d>", "<C-d>zz")

M.map("i", "`", "``<left>")
M.map("i", '"', '""<left>')
M.map("i", "(", "()<left>")
M.map("i", "[", "[]<left>")
M.map("i", "{", "{}<left>")
M.map("i", "<", "<><left>")

M.map({ "n", "v", "i" }, "<M-w>", function()
  local opt = require("options").opt
  opt.wrap = not opt.wrap:get()
end)

M.map({ "n", "v" }, "<leader>wl", "<C-w>h", { desc = "Goto window left" })
M.map({ "n", "v" }, "<leader>wr", "<C-w>l", { desc = "Goto window right" })
M.map({ "n", "v" }, "<leader>wu", "<C-w>k", { desc = "Goto window up" })
M.map({ "n", "v" }, "<leader>wd", "<C-w>j", { desc = "Goto window down" })

M.map({ "n", "v" }, "<leader>ws", function()
  vim.api.nvim_echo({ { "(← l | → r | ↑ u | ↓ d)" } }, false, {})
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
  else return
  end
end, { desc = "split window to direction" })

return M
