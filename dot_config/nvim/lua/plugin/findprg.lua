local M = {}

local start_dir = nil

function M.fd_findfunc(cmdarg, cmdcomplete)
  if not cmdcomplete and cmdarg ~= nil and cmdarg ~= "" then
    if vim.fn.filereadable(cmdarg) == 1 then
      return { cmdarg }
    end
  end

  local root = start_dir or vim.fn.cwd()

  local cmd = {
    "fd",
    "--glob",
    "--type", "file",
    "--color", "never",
    "--search-path", root,
    "--exclude", ".git",
    "--exclude", "target",
  }

  table.insert(cmd, cmdarg ~= nil and cmdarg ~= "" and cmdarg or "*")

  local results = vim.system(cmd, { text = true, stderr = false }):wait(3000)
  if results.code ~= 0 or not results.stdout then
    return {}
  end

  local files = vim.tbl_map(
    require("util").rel_to_pwd,
    vim.split(results.stdout, "\n", { trimempty = true })
  )

  return files
end

function M.fd_find_cwd()
  start_dir = vim.fn.getcwd()
  vim.api.nvim_input(":find ")
end

function M.fd_find_root()
  start_dir = require("util").getroot()
  vim.api.nvim_input(":find ")
end

function M.setup()
  if vim.fn.executable("fd") == 1 then
    _G.fd_findfunc = M.fd_findfunc
    vim.opt.findfunc = "v:lua.fd_findfunc"
  end
end

return M
