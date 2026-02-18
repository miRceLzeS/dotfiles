return {
  "stevearc/conform.nvim",
  event = "LspAttach",
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end,
}
