local M = {}

local loaded = {}
local group = vim.api.nvim_create_augroup("LazyPack", {})

function M.load(name, config)
  if loaded[name] then return end

  loaded[name] = true
  vim.cmd.packadd(name)

  if config then
    config()
  end
end

function M.pack(specs, config)
  vim.pack.add(specs, {
    confirm = false,
    load = true,
  })

  if config then
    config()
  end
end

function M.add(specs)
  vim.pack.add(specs, {
    confirm = false,
    load = function() end,
  })
end

function M.very_lazy(name, config)
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    once = true,
    callback = function()
      M.load(name, config)
    end,
  })
end

function M.event(events, name, config, opts)
  opts = opts or {}

  vim.api.nvim_create_autocmd(events, {
    group = group,
    pattern = opts.pattern,
    once = opts.once ~= false,
    callback = function()
      M.load(name, config)
    end,
  })
end

function M.keys(name, config, opts)
  for _, opt in ipairs(opts) do
    local mode = opt[1]
    local lhs = opt[2]
    local rhs = opt[3]
    local map_opts = opt[4] or {}

    require("keymap").map(mode, lhs, function()
      M.load(name, config)

      if type(rhs) == "string" then
        return rhs
      elseif type(rhs) == "function" then
        return rhs()
      end
    end, map_opts)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  once = true,
  callback = function()
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "VeryLazy",
        modeline = false,
      })
    end)
  end,
})

return M
