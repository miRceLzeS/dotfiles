local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.map({ "n" }, "<Esc>", "<CMD>nohlsearch<CR>")
M.map({ "n" }, "j", "gj")
M.map({ "n" }, "k", "gk")
M.map({ "n", "v", "i" }, "<M-w>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  if vim.opt.wrap:get() then
    vim.opt.linebreak = true
    vim.opt.breakindent = true
    vim.opt.showbreak = "↪ "
  end
end)

return M
