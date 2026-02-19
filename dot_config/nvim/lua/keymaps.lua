local M = {
  df_winid = nil
}

function M.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.unmap(mode, lhs, opts)
  M.map(mode, lhs, "<Nop>")
end

M.map({ "n" }, "<Esc>", "<Cmd>nohlsearch<CR>")

-- smart up and down movement
function M.smart_up()
  return vim.v.count == 0 and "gj" or "j"
end

function M.smart_down()
  return vim.v.count == 0 and "gk" or "k"
end

M.map({ "n" }, "j", M.smart_up, { expr = true })
M.map({ "n" }, "k", M.smart_down, { expr = true })
M.map({ "n" }, "<Up>", M.smart_up, { expr = true })
M.map({ "n" }, "<Down>", M.smart_down, { expr = true })

-- toggle wrap
M.map({ "n", "v", "i" }, "<M-w>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end)

-- true - close float window
-- false - error or untouch
function M.close_df()
  if M.df_winid and vim.api.nvim_win_is_valid(M.df_winid) then
    local ok, err = pcall(vim.api.nvim_win_close, M.df_winid, true)
    if not ok then
      vim.notify(err)
    end
    return ok
  end
  return false
end

function M.open_df()
  local function open_float()
    local _, winid = vim.diagnostic.open_float()
    M.df_winid = winid
  end
  vim.schedule(open_float)
end

M.unmap({ "n" }, "<C-w>d", "<Nop>")
-- toggle diagnostic float window
M.map({ "n" }, "<M-d>f", function()
  local toggle = M.close_df()
  if toggle then
    return
  end
  M.open_df()
end)
-- goto previous diagnostic
M.map({ "n" }, "[d", function()
  M.close_df()
  vim.diagnostic.goto_prev()
  M.open_df()
end)
-- goto next diagnostic
M.map({ "n" }, "]d", function()
  M.close_df()
  vim.diagnostic.goto_next()
  M.open_df()
end)

return M
