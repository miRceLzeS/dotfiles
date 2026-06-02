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

function M.nop(mode, lhs)
  vim.keymap.set(mode, lhs, "<Nop>", { noremap = true, silent = true })
end

-- [NOTE] operations inside buffer
-- === misc & muscle memory ===
M.del({ "n", "v" }, "s")
M.del({ "n", "v" }, "S")
M.nop({ "n", "v", "i" }, "<C-n>")
M.del({ "n", "v", "i" }, "<C-p>")

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
M.map("n", "<M-Up>", "<Cmd>m .-2<CR>==")
M.map("n", "<M-Down>", "<Cmd>m .+1<CR>==")
M.map("x", "<M-Up>", ":m '<-2<CR>gv=gv")
M.map("x", "<M-Down>", ":m '>+1<CR>gv=gv")
M.map("i", "<M-Up>", "<Esc><Cmd>m .-2<CR>==gi")
M.map("i", "<M-Down>", "<Esc><Cmd>m .+1<CR>==gi")

M.map({ "n", "x" }, "<M-Left>", "<gv")
M.map({ "n", "x" }, "<M-Right>", ">gv")

M.map({ "n", "x", "i" }, "<M-d>", "mzyyp`zj", { desc = "Duplicate current line" })

M.map("v", "<Leader>y", '"+y')

-- [NOTE] operations over neovim elements
-- === window ===
M.map("n", "<C-p>", "<Cmd>wincmd p<CR>")
M.map("n", "<C-s>k", "<Cmd>aboveleft split<CR>")
M.map("n", "<C-s>j", "<Cmd>split<CR>")
M.map("n", "<C-s>h", "<Cmd>leftabove vsplit<CR>")
M.map("n", "<C-s>l", "<Cmd>rightbelow vsplit<CR>")

-- === buffer ===
M.map({ "n", "x" }, "<Leader>bn", "<Cmd>enew<CR>")
M.map({ "n", "x" }, "<Leader>bd", "<Cmd>bdelete<CR>")

M.map({ "n", "x" }, "<Leader>bp", "<Cmd>b#<CR>")

M.map({ "n", "x" }, "<Leader>br", "<Cmd>edit!<CR>")

-- === tab ===
M.map({ "n", "x" }, "[<Tab>", "<Cmd>tabprevious<CR>")
M.map({ "n", "x" }, "]<Tab>", "<Cmd>tabnext<CR>")

M.map({ "n", "x" }, "<Leader><Tab>n", "<Cmd>tabnew<CR>")
M.map({ "n", "x" }, "<Leader><Tab>o", "<Cmd>tabonly<CR>")

-- === diagnostic ===
M.map({ "n", "x" }, "<Leader>ud", vim.diagnostic.open_float)

M.map({ "n", "x" }, "<Leader>d", function()
  vim.diagnostic.setloclist({
    open = true,
    title = "Local Diagnostics",
  })
end)

M.map({ "n", "x" }, "<Leader>D", function()
  vim.diagnostic.setqflist({
    open = true,
    title = "Workspace Diagnostics",
  })
end)

-- === search ===
M.map({ "n", "x" }, "<Leader>f", ":find ", { silent = false })
M.map({ "n", "x" }, "<Leader>F", function()
  local root = vim.fn.getcwd()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config and client.config.root_dir and client.config.root_dir ~= "" then
      root = client.config.root_dir
      break
    end
  end

  root = vim.fs.normalize(root)
  root = vim.fn.fnameescape(root)

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(":find " .. root .. "/", true, false, true), "n", false
  )
end, { silent = false })

local function search_symbol(range)
  local hint = range == 0 and "(buffer)" or "(workspace)"
  vim.ui.input({ prompt = "Symbol " .. hint .. "  " }, function(query)
    if query == nil or query == "" then return end

    local grep = "silent grep! -w " .. vim.fn.shellescape(query)
    if range == 0 then
      local filename = vim.fn.expand("%:p")
      if filename == "" then return end

      grep = grep .. " " .. vim.fn.shellescape(filename)
    end

    vim.cmd(grep .. " | copen")
  end)
end

M.map({ "n", "x" }, "<Leader>s", function() search_symbol(0) end)
M.map({ "n", "x" }, "<Leader>S", function() search_symbol(1) end)

-- === plugin ===
M.map({ "n" }, "<Leader>pu", vim.pack.update)

return M
