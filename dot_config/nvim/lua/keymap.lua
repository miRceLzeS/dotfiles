local M = {}

-- [NOTE] helper functions
function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }

  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.del(mode, lhs, opts)
  pcall(vim.keymap.del, mode, lhs, opts)
end

-- [NOTE] operations inside buffer
-- === misc & muscle memory ===
M.del({ "n", "v" }, "s")
M.del({ "n", "v" }, "<C-n>")
M.del({ "n", "v" }, "<C-p>")

M.map("n", "<Esc>", "<Cmd>nohlsearch<CR>")
M.map("t", "<Esc>", "<C-\\><C-n>")

M.map("n", "U", "<C-r>")

M.map({ "n", "x" }, "<C-u>", "<C-u>zz")
M.map({ "n", "x" }, "<C-d>", "<C-d>zz")

-- === navigation ===
M.map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
M.map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
M.map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })
M.map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })

M.map({ "n", "x", "o" }, "gh", "0^")
M.map({ "n", "x", "o" }, "gl", "$")

M.map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true })
M.map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true })
M.map("x", "n", "'Nn'[v:searchforward]", { expr = true })
M.map("x", "N", "'nN'[v:searchforward]", { expr = true })
M.map("o", "n", "'Nn'[v:searchforward]", { expr = true })
M.map("o", "N", "'nN'[v:searchforward]", { expr = true })

-- === text ===
M.map("n", "<M-k>", "<Cmd>m .-2<CR>==")
M.map("n", "<M-j>", "<Cmd>m .+1<CR>==")
M.map("x", "<M-k>", ":m '<-2<CR>gv=gv")
M.map("x", "<M-j>", ":m '>+1<CR>gv=gv")
M.map("i", "<M-k>", "<Esc><Cmd>m .-2<CR>==gi")
M.map("i", "<M-j>", "<Esc><Cmd>m .+1<CR>==gi")

M.map("x", "<", "<gv")
M.map("x", ">", ">gv")

M.map({ "n", "x", "i" }, "<M-d>", "mzyyp`zj", { desc = "Duplicate current line" })

M.map("v", "<Leader>y", '"+y')

-- [NOTE] operations over neovim elements
-- === window ===
M.map("n", "<C-p>", "<Cmd>wincmd p<CR>")

M.map("n", "<C-n>k", "<Cmd>aboveleft split<CR>")
M.map("n", "<C-n>j", "<Cmd>split<CR>")
M.map("n", "<C-n>h", "<Cmd>leftabove vsplit<CR>")
M.map("n", "<C-n>l", "<Cmd>rightbelow vsplit<CR>")

-- === buffer ===
M.map({ "n", "x" }, "<Leader>bn", "<Cmd>enew<CR>")
M.map({ "n", "x" }, "<Leader>bd", "<Cmd>bdelete<CR>")

M.map({ "n", "x" }, "<Leader>b[", "<Cmd>bprevious<CR>")
M.map({ "n", "x" }, "<Leader>b]", "<Cmd>bnext<CR>")
M.map({ "n", "x" }, "<Leader>bp", "<Cmd>b#<CR>")

M.map({ "n", "x" }, "<Leader>br", "<Cmd>edit!<CR>")

-- === tab ===
M.map({ "n", "x" }, "<Leader><Tab>n", "<Cmd>tabnew<CR>")
M.map({ "n", "x" }, "<Leader><Tab>o", "<Cmd>tabonly<CR>")

M.map({ "n", "x" }, "<Leader><Tab>[", "<Cmd>tabprevious<CR>")
M.map({ "n", "x" }, "<Leader><Tab>]", "<Cmd>tabnext<CR>")
M.map({ "n", "x" }, "<Leader><Tab>p", "<Cmd>tablast<CR>")

-- === plugin ===
M.map({ "n" }, "<Leader>pu", vim.pack.update)

return M
