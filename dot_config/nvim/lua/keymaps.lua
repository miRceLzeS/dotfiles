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
end)
M.map({ "n", "v", "i" }, "<M-d>", function()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
end)

return M
