local M = {}

local defaults = {
  excludes = {
    ".git",
    "node_modules",
    "dist",
    "build",
    "target",
    ".next",
    "coverage",
  },
  hidden = true,
  max_results = 100,
  complete_max_results = 1000,
  timeout_ms = 2000,
  cwd = nil,
}

local opts = vim.deepcopy(defaults)

local function has_vim_system()
  return type(vim.system) == "function"
end

local function fd_bin()
  if vim.fn.executable("fd") == 1 then
    return "fd"
  end

  return nil
end

local function is_complete_mode(cmdcomplete)
  return cmdcomplete == true or cmdcomplete == 1
end

local function build_fd_cmd(arg, cmdcomplete)
  local fd = fd_bin()

  if not fd then
    return nil, "fd not found"
  end

  local limit = is_complete_mode(cmdcomplete)
      and opts.complete_max_results
      or opts.max_results

  local cmd = {
    fd,
    "--type", "file",
    "--color", "never",
    "--max-results", tostring(limit),
  }

  if opts.hidden then
    table.insert(cmd, "--hidden")
  end

  for _, pat in ipairs(opts.excludes or {}) do
    vim.list_extend(cmd, { "--exclude", pat })
  end

  if arg ~= nil and arg ~= "" then
    vim.list_extend(cmd, {
      "--full-path",
      "--fixed-strings",
      "--",
      arg,
    })
  else
    table.insert(cmd, ".")
  end

  return cmd, nil
end

local function run_fd(cmd)
  local cwd = opts.cwd or vim.fn.getcwd()

  if has_vim_system() then
    local result = vim.system(cmd, {
      cwd = cwd,
      text = true,
      stderr = false,
    }):wait(opts.timeout_ms)

    if result.code ~= 0 or not result.stdout then
      return {}
    end

    return vim.split(result.stdout, "\n", { trimempty = true })
  end

  local old_cwd = vim.fn.getcwd()

  local ok, result = pcall(function()
    vim.cmd.lcd(vim.fn.fnameescape(cwd))
    return vim.fn.systemlist(cmd)
  end)

  pcall(vim.cmd.lcd, vim.fn.fnameescape(old_cwd))

  if not ok or vim.v.shell_error ~= 0 then
    return {}
  end

  return result
end

function M.findfunc(arg, cmdcomplete)
  local cmd, err = build_fd_cmd(arg, cmdcomplete)

  if not cmd then
    vim.notify(err, vim.log.levels.WARN)
    return {}
  end

  return run_fd(cmd)
end

function M.setup(user_opts)
  opts = vim.tbl_deep_extend("force", defaults, user_opts or {})

  _G.__fd_findfunc = M.findfunc

  vim.opt.findfunc = "v:lua.__fd_findfunc"

  vim.opt.path = { "." }
end

return M
