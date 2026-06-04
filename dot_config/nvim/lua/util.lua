local M = {}

function M.getroot()
  local root = vim.fn.getcwd()

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.config and client.config.root_dir and client.config.root_dir ~= "" then
      root = client.config.root_dir
      break
    end
  end

  return root
end

function M.rel_to_pwd(path)
  local target = vim.fs.normalize(vim.fs.abspath(path))
  local base = vim.fs.normalize(vim.fs.abspath(vim.fn.getcwd()))

  local rel = vim.fs.relpath(base, target)
  if rel then
    return rel == "" and "." or rel
  end

  local up = ".."

  for parent in vim.fs.parents(base) do
    rel = vim.fs.relpath(parent, target)

    if rel then
      return rel == "" and up or vim.fs.joinpath(up, rel)
    end

    up = up .. "/.."
  end

  return target
end

return M
