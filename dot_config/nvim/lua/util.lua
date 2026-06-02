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
  return vim.fs.relpath(vim.fn.getcwd(), path) or path
end

return M
