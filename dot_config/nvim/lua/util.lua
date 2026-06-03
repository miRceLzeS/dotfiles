local M = {}

function M.getroot()
  local root = vim.fn.getcwd()

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config and client.config.root_dir and client.config.root_dir ~= "" then
      root = client.config.root_dir
      break
    end
  end

  return vim.fs.normalize(vim.fn.fnameescape(root))
end

function M.rel_to_pwd(path)
  local target = vim.fs.normalize(path)
  local base = vim.fs.normalize(vim.fn.getcwd())

  local rel = vim.fs.relpath(base, target)
  if rel then
    return rel == "" and "." or rel
  end

  local parent = base
  local ups = {}

  while true do
    local next_parent = vim.fs.dirname(parent)

    if next_parent == parent then
      return target
    end

    parent = next_parent
    table.insert(ups, "..")

    rel = vim.fs.relpath(parent, target)
    if rel then
      if rel == "" or rel == "." then
        return table.concat(ups, "/")
      end

      table.insert(ups, rel)
      return table.concat(ups, "/")
    end
  end
end

return M
